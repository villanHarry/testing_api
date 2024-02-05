// To parse this JSON data, do
//
//     final signUpModel = signUpModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SignUpModel signUpModelFromJson(String str) =>
    SignUpModel.fromJson(json.decode(str));

String signUpModelToJson(SignUpModel data) => json.encode(data.toJson());

class SignUpModel {
  String? message;
  int? status;
  Data? data;

  SignUpModel({
    this.message,
    this.status,
    this.data,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
        message: json["message"],
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data!.toJson(),
      };
}

class Data {
  String? accessToken;
  SavedUser? savedUser;

  Data({
    this.accessToken,
    this.savedUser,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        accessToken: json["access_token"],
        savedUser: SavedUser.fromJson(json["savedUser"]),
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "savedUser": savedUser!.toJson(),
      };
}

class SavedUser {
  String? email;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  SavedUser({
    this.email,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory SavedUser.fromJson(Map<String, dynamic> json) => SavedUser(
        email: json["email"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "_id": id,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
      };
}
