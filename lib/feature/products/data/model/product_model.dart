class ProductModel {
  final int id;
  final String name;
  final int price;
  final String category;
  final String weight;
  final String expiry;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.weight,
    required this.expiry,
  });

  // From JSON
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      price: json['price'] ?? 0,
      category: json['category'] ?? '',
      weight: json['weight'] ?? '',
      expiry: json['expiry'] ?? '',
    );
  }

  static List<ProductModel> fromJsonList(List<dynamic>? jsonList) {
    print(jsonList);
    final valueList = jsonList?.map(
      (dynamic json) => ProductModel.fromJson(json as Map<String, dynamic>),
    );
    return valueList?.toList() ?? [];
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'category': category,
      'weight': weight,
      'expiry': expiry,
    };
  }
}
