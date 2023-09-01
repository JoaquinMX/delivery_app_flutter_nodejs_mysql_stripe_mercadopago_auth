import 'dart:convert';

import 'package:delivery_app/src/models/rol.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {

  String? id;
  String? email;
  String? name;
  String? lastname;
  String? phone;
  String? image;
  String? password;
  String? sessionToken;
  List<Rol>? roles = [];

  User({
    this.id,
    this.email,
    required this.name,
    required this.lastname,
    required this.phone,
    this.image,
    this.password,
    this.sessionToken,
    this.roles
  });



  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    email: json["email"],
    name: json["name"],
    lastname: json["lastname"],
    phone: json["phone"],
    image: json["image"],
    password: json["password"],
    sessionToken: json["session_token"],
    roles: json["roles"] == null ? [] : List<Rol>.from(json["roles"].map((model) => Rol.fromJson(model))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "name": name,
    "lastname": lastname,
    "phone": phone,
    "image": image,
    "password": password,
    "session_token": sessionToken,
    "roles": roles
  };
}
