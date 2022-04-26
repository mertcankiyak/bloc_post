// To parse this JSON data, do
//
//     final requestUserModel = requestUserModelFromJson(jsonString);

import 'dart:convert';
import 'package:vexana/vexana.dart';

RequestUserModel requestUserModelFromJson(String str) =>
    RequestUserModel.fromJson(json.decode(str));

String requestUserModelToJson(RequestUserModel data) =>
    json.encode(data.toJson());

class RequestUserModel extends INetworkModel {
  RequestUserModel({
    this.email,
    this.password,
  });

  String? email;
  String? password;

  factory RequestUserModel.fromJson(Map<String, dynamic> json) =>
      RequestUserModel(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };

  @override
  fromJson(Map<String, dynamic> json) {
    return RequestUserModel.fromJson(json);
  }
}
