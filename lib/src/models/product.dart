import 'dart:convert';

Product categoryFromJson(String str) => Product.fromJson(json.decode(str));

String categoryToJson(Product data) => json.encode(data.toJson());

class Product {
  String? id;
  String? name;
  String? description;
  String? image1;
  String? image2;
  String? image3;
  String? id_category;
  double? price;
  int? quantity;

  Product({
    this.id,
    required this.name,
    required this.description,
    this.image1,
    this.image2,
    this.image3,
    required this.id_category,
    required this.price,
    this.quantity,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    image1: json["image1"],
    image2: json["image2"],
    image3: json["image3"],
    id_category: json["id_category"],
    price: double.parse(json["price"]),
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "image1": image1,
    "image2": image2,
    "image3": image3,
    "id_category": id_category,
    "price": price,
    "quantity": quantity,
  };

  static List<Product> fromJsonList(List<dynamic> jsonList) {
    List<Product> toList = [];

    jsonList.forEach((item) {
      Product category = Product.fromJson(item);
      toList.add(category);
    });

    return toList;
  }
}
