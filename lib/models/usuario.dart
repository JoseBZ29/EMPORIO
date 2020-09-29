import 'package:flutter/material.dart';

class User {
  int idCliente = 0;
  String name = "";
  String mail = "";
  String cellular = "";
  User({
    @required this.idCliente,
    @required this.name,
    @required this.mail,
    @required this.cellular,
  });

  static User fromJson(Map<String, dynamic> json) {
    return User(
      idCliente: json["id_user"],
      name: json["nombres"],
      mail: json["email"],
      cellular: json["telefono"],
    );
  }
}
