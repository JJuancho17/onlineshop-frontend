import 'dart:convert';

import 'Rol.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {

  int? id;
  String? username;
  String? email;
  String? name;
  String? lastname;
  String? phone;
  String? image;
  String? password;
  String? token;
  List<Rol>? roles = [];


  User({
    this.id,
    this.username,
    this.email,
    this.name,
    this.lastname,
    this.phone,
    this.image,
    this.password,
    this.token,
    this.roles
  });



  factory User.fromJson(Map<String, dynamic> json){
    return User(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        name: json["name"],
        lastname: json["lastname"],
        phone: json["phone"],
        image: json["image"],
        password: json["password"],
        token: json['token'],
        roles: json["roles"] == null ? [] : List<Rol>.from(json["roles"].map((model) => Rol.fromJson(model))) ?? [],
    );
  }

  static List<User> fromJsonList(List<dynamic> jsonList) {
    List<User> toList = [];
    jsonList.forEach((item) {
      User users = User.fromJson(item);
      toList.add(users);
    });
    return toList;
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "name": name,
    "lastname": lastname,
    "phone": phone,
    "image": image,
    "password": password,
    "token": token,
    "roles": roles
  };
}
