// To parse this JSON data, do
//
//     final courierStatusActiveModel = courierStatusActiveModelFromJson(jsonString);

import 'dart:convert';

List<CourierStatusActiveModel> courierStatusActiveModelFromJson(String str) =>
    List<CourierStatusActiveModel>.from(
        json.decode(str).map((x) => CourierStatusActiveModel.fromJson(x)));

String courierStatusActiveModelToJson(List<CourierStatusActiveModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CourierStatusActiveModel {
  int id;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  CourierStatusActiveModel({
    required this.id,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CourierStatusActiveModel.fromJson(Map<String, dynamic> json) =>
      CourierStatusActiveModel(
        id: json["id"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
