import 'dart:convert';

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

  User({
    this.id,
    required this.email,
    required this.name,
    required this.lastname,
    required this.phone,
    this.image,
    required this.password,
  });



  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    email: json["email"],
    name: json["name"],
    lastname: json["lastname"],
    phone: json["phone"],
    image: json["image"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "name": name,
    "lastname": lastname,
    "phone": phone,
    "image": image,
    "password": password,
  };
}
