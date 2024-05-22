/// базовая обработка http ошибок
/// [message] тело ошибки
/// [code] http код ошибки
class HttpRequestException<T> implements Exception {
  int code;
  String? message;
  String? field;
  HttpTypeError? httpTypeError;

  factory HttpRequestException.fromJson(
    Map<String, dynamic> json,
  ) =>
      HttpRequestException(
        code: json['error']['status_code'] as int,
        message: json['error']['message'] as String?,
        field: json['error']['field'] as String?,
      );

  HttpRequestException({
    required this.code,
    this.message,
    this.field,
    this.httpTypeError,
  });
}

enum HttpTypeError {
  unknown,
  notInternetConnection,
  http,
}

class GlobalAuthException implements Exception {
  GlobalAuthException({
    this.json,
    this.message,
    this.code = 500,
    this.httpTypeError = HttpTypeError.http,
  });

  factory GlobalAuthException.fromJson(Map<String, dynamic> json, int code) {
    try {
      return GlobalAuthException(
        json: json,
        code: code,
        message: json['error'] as String?,
      );
    } catch (e) {
      throw 'e';
    }
  }

  List<String>? get email =>
      (json?['username'] as List?)?.map((item) => item.toString()).toList();

  List<String>? get password =>
      (json?['password'] as List?)?.map((item) => item.toString()).toList();

  List<String>? get name =>
      (json?['first_name'] as List?)?.map((item) => item.toString()).toList();

  final int code;
  final String? message;
  final HttpTypeError httpTypeError;
  final Map<String, dynamic>? json;
}
