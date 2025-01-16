// To parse this JSON data, do
//
//     final updateImageOrder = updateImageOrderFromJson(jsonString);

import 'dart:convert';

List<UpdateImageOrder> updateImageOrderFromJson(String str) =>
    List<UpdateImageOrder>.from(
        json.decode(str).map((x) => UpdateImageOrder.fromJson(x)));

String updateImageOrderToJson(List<UpdateImageOrder> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UpdateImageOrder {
  int id;
  int userId;
  int courierId;
  int statusOrderId;
  int totalCost;
  String image;
  DateTime createdAt;
  DateTime updatedAt;

  UpdateImageOrder({
    required this.id,
    required this.userId,
    required this.courierId,
    required this.statusOrderId,
    required this.totalCost,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UpdateImageOrder.fromJson(Map<String, dynamic> json) =>
      UpdateImageOrder(
        id: json["id"],
        userId: json["user_id"],
        courierId: json["courier_id"],
        statusOrderId: json["status_order_id"],
        totalCost: json["total_cost"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "courier_id": courierId,
        "status_order_id": statusOrderId,
        "total_cost": totalCost,
        "image": image,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
