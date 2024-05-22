import 'dart:async';
import 'dart:developer';
import 'package:barcode_scanner/core/constants/global_constant.dart';
import 'package:barcode_scanner/core/utils/exeption/error.dart';
import 'package:barcode_scanner/core/utils/exeption/exception.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';

/// функция для получения резултата
typedef ResponseJson<T> = T Function(Map<String, dynamic>);

/// функция для списка обьектов
typedef ResponseListJson<T> = T Function(List<dynamic>);

/// функция для получения пользователькой ошибка
/// [dynamic] ошибка в виде json
/// [String] ошибка по умалчанию
typedef ErrorResponsePrinter<T> = Exception Function(Map<String, dynamic>, int);

/// вызов безопасно http функцию с обработкой пользовтелькой ошибки, а также обратный вызов для работы с
/// локальной базов в лучае какой либо ошибки
/// T отвер сервера
Future<T> safeApiCallWithDataBase<T>({
  Map<String, dynamic> Function()? onQueryDataBase,
  Future<Response>? networkCall,
  Function(Map<String, dynamic>)? onSaveDataBase,
  required ResponseJson<T> onResult,
}) async {
  try {
    final result = await networkCall;
    final json = await result?.data;
    onSaveDataBase?.call(json);
    return onResult.call(json);
  } catch (ex) {
    if (ex is DioException) {
      final dataBaseValue = onQueryDataBase?.call();
      if (dataBaseValue?.isEmpty ?? false) {
        return onResult.call(dataBaseValue!);
      }
      final data = ex.response?.data;
      final message = _handleDioErrorType(ex.type, data);
      throw HttpRequestException<String>(
        message: message,
        code: ex.response?.statusCode ?? GlobalConstant.negative,
        httpTypeError: HttpTypeError.http,
      );
    }
    throw _throwDefaultError(ex);
  }
}

/// вызов безопасно http функцию с обработкой пользовтелькой ошибки
/// [T] отвер сервера
Future<T> safeApiCallList<T>(
  Future<Response> response,
  ResponseListJson<T> jsonCall, {
  bool? isTest,
}) async {
  await _makeThrowInternetConnection(isTest ?? false);
  try {
    final result = await response;
    final json = result.data;
    return jsonCall.call(json);
  } catch (ex) {
    if (ex is DioException) {
      final data = ex.response?.data;
      final message = _handleDioErrorType(ex.type, data);
      throw HttpRequestException<String>(
        message: message,
        code: ex.response?.statusCode ?? GlobalConstant.negative,
        httpTypeError: HttpTypeError.http,
      );
    }
    throw _throwDefaultError(ex);
  }
}

/// вызов безопасно http функцию с обработкой пользовтелькой ошибки
/// [T] отвер сервера
Future<T> safeApiCall<T>(
  Future<Response> response,
  ResponseJson<T> jsonCall, {
  bool? isTest,
}) async {
  await _makeThrowInternetConnection(isTest ?? false);
  try {
    final result = await response;
    final json = result.data;
    return jsonCall.call(json);
  } catch (ex) {
    log(ex.runtimeType.toString());
    if (ex is DioException) {
      final data = ex.response?.data;
      log(ex.type.toString());
      log(data.toString());
      final message = _handleDioErrorType(ex.type, data);

      throw HttpRequestException<String>(
        message: message,
        code: ex.response?.statusCode ?? GlobalConstant.negative,
        httpTypeError: HttpTypeError.http,
      );
    }
    throw _throwDefaultError(ex);
  }
}

/// вызов безопасно http функцию возвращает void (вызывать в случае пустого ответа)
/// [response] - ответ от сервера
Future<void> safeApiCallVoid(
  Future<Response> response, {
  bool? isTest,
}) async {
  await _makeThrowInternetConnection(isTest ?? false);
  try {
    await response;
    return;
  } catch (ex) {
    if (ex is DioException) {
      final data = ex.response?.data;
      final message = _handleDioErrorType(ex.type, data);
      throw HttpRequestException<String>(
        message: message,
        code: ex.response?.statusCode ?? GlobalConstant.negative,
        httpTypeError: HttpTypeError.http,
      );
    }
    throw _throwDefaultError(ex);
  }
}

/// вызов безопасно http функцию
/// T отвер сервера
/// V ответ сервера в виде ошибки
Future<T> safeApiCallWithError<T, V>(
  Future<Response> response,
  ResponseJson<T> jsonCall,
  ErrorResponsePrinter<V> errorResponsePrinter, {
  bool? isTest,
}) async {
  await _makeThrowInternetConnection(isTest ?? false);
  try {
    final result = await response;
    final json = result.data;
    return jsonCall.call(json);
  } catch (ex) {
    if (ex is DioException) {
      final data = ex.response?.data;
      throw errorResponsePrinter.call(
        data,
        ex.response?.statusCode ?? GlobalConstant.negative,
      );
    }

    throw _throwDefaultError(ex);
  }
}

/// вызов безопасно http функцию
/// T отвер сервера
/// V ответ сервера в виде ошибки
Future<void> safeApiVoidCallWithError<V>(
  Future<Response> response,
  ErrorResponsePrinter<V> errorResponsePrinter, {
  bool? isTest,
}) async {
  await _makeThrowInternetConnection(isTest ?? false);
  try {
    await response;
    return;
  } catch (ex) {
    if (ex is DioException) {
      final data = ex.response?.data;
      throw errorResponsePrinter.call(
        data,
        ex.response?.statusCode ?? GlobalConstant.negative,
      );
    }

    throw _throwDefaultError(ex);
  }
}

/// выкидывает исключение в виде ошибки по умалчанию
HttpRequestException<String> _throwDefaultError(exception) {
  return HttpRequestException<String>(
    message: exception.toString(),
    code: GlobalConstant.zeroInt,
    httpTypeError: HttpTypeError.http,
  );
}

/// вызывает исключение при отсутсии интернета
Future<HttpRequestException<String>?> _makeThrowInternetConnection(
  bool isTest,
) async {
  if (isTest == false) {
    final isInternetConnection = await _checkInternetConnection();
    if (!isInternetConnection) {
      throw HttpRequestException<String>(
        message: "Нет интернет соеденения",
        code: GlobalConstant.negative,
        httpTypeError: HttpTypeError.notInternetConnection,
      );
    }
  }
  return null;
}

/// проверка интернет соеденения
Future<bool> _checkInternetConnection() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
  return false;
}

/// обработчик ошибок по типу ошибко [Dio]
/// [DioExceptionType] ошибка
String _handleDioErrorType(DioExceptionType ex, [Map<String, dynamic>? data]) {
  switch (ex) {
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      {
        return "Время таймаута истекло";
      }
    default:
      {
        return data != null
            ? ErrorData.fromJson(data).message
            : "Ошибка сервера";
      }
  }
}
