// To parse this JSON data, do
//
//     final courierModel = courierModelFromJson(jsonString);

import 'dart:convert';

List<CourierModel> courierModelFromJson(String str) => List<CourierModel>.from(
    json.decode(str).map((x) => CourierModel.fromJson(x)));

String courierModelToJson(List<CourierModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CourierModel {
  int id;
  String name;
  String email;
  String phone;
  dynamic emailVerifiedAt;
  int roleId;
  DateTime createdAt;
  DateTime updatedAt;
  List<Status> status;

  CourierModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.emailVerifiedAt,
    required this.roleId,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
  });

  factory CourierModel.fromJson(Map<String, dynamic> json) => CourierModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        emailVerifiedAt: json["email_verified_at"],
        roleId: json["role_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        status:
            List<Status>.from(json["status"].map((x) => Status.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "email_verified_at": emailVerifiedAt,
        "role_id": roleId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "status": List<dynamic>.from(status.map((x) => x.toJson())),
      };
}

class Status {
  int id;
  int userId;
  int courierStatusActiveId;
  int courierStatusAvailableId;
  DateTime createdAt;
  DateTime updatedAt;
  String courierStatusActivesName;
  String courierStatusAvailablesName;

  Status({
    required this.id,
    required this.userId,
    required this.courierStatusActiveId,
    required this.courierStatusAvailableId,
    required this.createdAt,
    required this.updatedAt,
    required this.courierStatusActivesName,
    required this.courierStatusAvailablesName,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        id: json["id"],
        userId: json["user_id"],
        courierStatusActiveId: json["courier_status_active_id"],
        courierStatusAvailableId: json["courier_status_available_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        courierStatusActivesName: json["courier_status_actives_name"],
        courierStatusAvailablesName: json["courier_status_availables_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "courier_status_active_id": courierStatusActiveId,
        "courier_status_available_id": courierStatusAvailableId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "courier_status_actives_name": courierStatusActivesName,
        "courier_status_availables_name": courierStatusAvailablesName,
      };
}
