// To parse this JSON data, do
//
//     final address = addressFromJson(jsonString);

import 'dart:convert';

Address addressFromJson(String str) => Address.fromJson(json.decode(str));

String addressToJson(Address data) => json.encode(data.toJson());

class Address {
  String? id;
  String address;
  String neighborhood;
  String idUser;
  double lat;
  double lng;

  Address({
    this.id,
    required this.address,
    required this.neighborhood,
    required this.idUser,
    required this.lat,
    required this.lng,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        address: json["address"] ?? "",
        neighborhood: json["neighborhood"],
        idUser: json["id_user"],
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "address": address,
        "neighborhood": neighborhood,
        "id_user": idUser,
        "lat": lat,
        "lng": lng,
      };

  static List<Address> fromJsonList(List<dynamic> jsonList) {
    List<Address> toList = [];

    jsonList.forEach((item) {
      Address address = Address.fromJson(item);
      toList.add(address);
    });

    return toList;
  }
}
