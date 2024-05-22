class ProductDetailsModel {
  final String name;
  final String type;
  final double price;
  final List<String> barcodes;
  final String description;
  final NutritionalInfo nutritionalInfo;
  final List<ImageData> images;

  ProductDetailsModel({
    required this.name,
    required this.type,
    required this.price,
    required this.barcodes,
    required this.description,
    required this.nutritionalInfo,
    required this.images,
  });

  // From JSON
  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      price: json['price'] ?? 0.00,
      barcodes: List<String>.from(json['barcodes'] ?? []),
      description: json['description'] ?? '',
      nutritionalInfo: NutritionalInfo.fromJson(
          json['nutritional_info'] as Map<String, dynamic>),
      images: (json['images'] as List<dynamic>)
          .map((imageJson) =>
              ImageData.fromJson(imageJson as Map<String, dynamic>))
          .toList(),
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'price': price,
      'barcodes': barcodes,
      'description': description,
      'nutritional_info': nutritionalInfo.toJson(),
      'images': images.map((image) => image.toJson()).toList(),
    };
  }
}

class NutritionalInfo {
  final int calories;
  final double fat;
  final int carbohydrates;
  final double protein;

  NutritionalInfo({
    required this.calories,
    required this.fat,
    required this.carbohydrates,
    required this.protein,
  });

  // From JSON
  factory NutritionalInfo.fromJson(Map<String, dynamic> json) {
    return NutritionalInfo(
      calories: json['calories'] ?? 0,
      fat: json['fat'] ?? 0.00,
      carbohydrates: json['carbohydrates'] ?? 0,
      protein: json['protein'] ?? 0.00,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'calories': calories,
      'fat': fat,
      'carbohydrates': carbohydrates,
      'protein': protein,
    };
  }
}

class ImageData {
  final String url;
  final String altText;

  ImageData({
    required this.url,
    required this.altText,
  });

  // From JSON
  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      url: json['url'] ?? '',
      altText: json['alt_text'] ?? '',
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'alt_text': altText,
    };
  }
}
