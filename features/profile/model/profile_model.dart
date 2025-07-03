// To parse this JSON data, do
//
//     final profilemodel = profilemodelFromJson(jsonString);

import 'dart:convert';

ProfileModel profilemodelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profilemodelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  final bool? success;
  final String? message;
  final Result? result;

  ProfileModel({
    this.success,
    this.message,
    this.result,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    success: json["success"],
    message: json["message"],
    result: json["result"] == null ? null : Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "result": result?.toJson(),
  };
}

class Result {
  final String? id;
  final String? fullName;
  final String? profileImage;
  final String? email;

  Result({
    this.id,
    this.fullName,
    this.profileImage,
    this.email,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    fullName: json["fullName"],
    profileImage: json["profileImage"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullName": fullName,
    "profileImage": profileImage,
    "email": email,
  };
}
