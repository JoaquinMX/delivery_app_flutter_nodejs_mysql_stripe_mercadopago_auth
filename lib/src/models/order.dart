import 'dart:convert';

import 'package:delivery_app/src/models/product.dart';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
  String? id;
  String idClient;
  String? idDelivery;
  String idAddress;
  String? status;
  double lat;
  double lng;
  int? timestamp;
  List<Product> products = [];

  Order({
    this.id,
    required this.idClient,
    this.idDelivery,
    required this.idAddress,
    this.status,
    required this.lat,
    required this.lng,
    this.timestamp,
    required this.products,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        idClient: json["id_client"],
        idDelivery: json["id_delivery"],
        idAddress: json["id_address"],
        status: json["status"],
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
        timestamp: json["timestamp"],
        products: json["products"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_client": idClient,
        "id_delivery": idDelivery,
        "id_address": idAddress,
        "status": status,
        "lat": lat,
        "lng": lng,
        "timestamp": timestamp,
        "products": products
      };
}
