// To parse this JSON data, do
//
//     final responseTokenModel = responseTokenModelFromJson(jsonString);

import 'dart:convert';
import 'package:vexana/vexana.dart';

ResponseTokenModel responseTokenModelFromJson(String str) =>
    ResponseTokenModel.fromJson(json.decode(str));

String responseTokenModelToJson(ResponseTokenModel data) =>
    json.encode(data.toJson());

class ResponseTokenModel extends INetworkModel {
  ResponseTokenModel({
    this.token,
  });

  String? token;

  factory ResponseTokenModel.fromJson(Map<String, dynamic> json) =>
      ResponseTokenModel(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };

  @override
  fromJson(Map<String, dynamic> json) {
    return ResponseTokenModel.fromJson(json);
  }
}
