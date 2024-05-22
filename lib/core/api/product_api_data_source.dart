import 'package:dio/dio.dart';

class ProductApiDataSource {
  final Dio _dio;

  ProductApiDataSource(this._dio);

  Future<Response> fetchProducts() async {
    return _dio.get('products.json');
  }

  Future<Response> fetchProductDetails(String id) async {
    return _dio.get(id);
  }

  // Имплементация ответа сервера
  Future<Response> scanBarcode(String barcode) async {
    if (["1234567890", "0987654321"].contains(barcode)) {
      return Response(
        requestOptions: RequestOptions(),
        data: appleEntity,
        statusCode: 200,
      );
    }
    throw DioException.badResponse(
      requestOptions: RequestOptions(),
      statusCode: 404,
      response: Response(
        requestOptions: RequestOptions(),
        data: {'message': 'Продукт не найден.'},
      ),
    );
  }
}

const appleEntity = {
  "name": "Яблоко Гала",
  "type": "Бакалея",
  "price": 0.75,
  "barcodes": ["1234567890", "0987654321"],
  "description":
      "Яблоко Гала - это гибрид сортов Kidd's Orange Red и Golden Delicious. Оно имеет сладкий, мягкий вкус и хрустящую текстуру. Это популярное яблоко для употребления в свежем виде, но также может использоваться для выпечки.",
  "nutritional_info": {
    "calories": 80,
    "fat": 0.5,
    "carbohydrates": 22,
    "protein": 0.5
  },
  "images": [
    {
      "url": "https://picsum.photos/200/300",
      "alt_text": "Яблоко Гала крупным планом"
    },
    {
      "url": "https://picsum.photos/200/300",
      "alt_text": "Яблоко Гала на тарелке"
    }
  ]
};
