// To parse this JSON data, do
//
//     final adminCourierModel = adminCourierModelFromJson(jsonString);

import 'dart:convert';

List<AdminCourierModel> adminCourierModelFromJson(String str) =>
    List<AdminCourierModel>.from(
        json.decode(str).map((x) => AdminCourierModel.fromJson(x)));

String adminCourierModelToJson(List<AdminCourierModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AdminCourierModel {
  int id;
  int userId;
  int courierStatusActiveId;
  int courierStatusAvailableId;
  DateTime createdAt;
  DateTime updatedAt;
  String courierName;
  String courierPhone;
  String courierEmail;

  AdminCourierModel({
    required this.id,
    required this.userId,
    required this.courierStatusActiveId,
    required this.courierStatusAvailableId,
    required this.createdAt,
    required this.updatedAt,
    required this.courierName,
    required this.courierPhone,
    required this.courierEmail,
  });

  factory AdminCourierModel.fromJson(Map<String, dynamic> json) =>
      AdminCourierModel(
        id: json["id"],
        userId: json["user_id"],
        courierStatusActiveId: json["courier_status_active_id"],
        courierStatusAvailableId: json["courier_status_available_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        courierName: json["courier_name"],
        courierPhone: json["courier_phone"],
        courierEmail: json["courier_email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "courier_status_active_id": courierStatusActiveId,
        "courier_status_available_id": courierStatusAvailableId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "courier_name": courierName,
        "courier_phone": courierPhone,
        "courier_email": courierEmail,
      };
}
