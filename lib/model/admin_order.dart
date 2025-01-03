// To parse this JSON data, do
//
//     final adminOrderModel = adminOrderModelFromJson(jsonString);

import 'dart:convert';

List<AdminOrderModel> adminOrderModelFromJson(String str) =>
    List<AdminOrderModel>.from(
        json.decode(str).map((x) => AdminOrderModel.fromJson(x)));

String adminOrderModelToJson(List<AdminOrderModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AdminOrderModel {
  Order order;
  List<Detail> detail;

  AdminOrderModel({
    required this.order,
    required this.detail,
  });

  factory AdminOrderModel.fromJson(Map<String, dynamic> json) =>
      AdminOrderModel(
        order: Order.fromJson(json["order"]),
        detail:
            List<Detail>.from(json["detail"].map((x) => Detail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "order": order.toJson(),
        "detail": List<dynamic>.from(detail.map((x) => x.toJson())),
      };
}

class Detail {
  int id;
  int ordersId;
  int productId;
  int amount;
  int cost;
  DateTime createdAt;
  DateTime updatedAt;
  String productName;
  String productImage;

  Detail({
    required this.id,
    required this.ordersId,
    required this.productId,
    required this.amount,
    required this.cost,
    required this.createdAt,
    required this.updatedAt,
    required this.productName,
    required this.productImage,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"],
        ordersId: json["orders_id"],
        productId: json["product_id"],
        amount: json["amount"],
        cost: json["cost"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        productName: json["product_name"],
        productImage: json["product_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "orders_id": ordersId,
        "product_id": productId,
        "amount": amount,
        "cost": cost,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "product_name": productName,
        "product_image": productImage,
      };
}

class Order {
  int id;
  int userId;
  int? courierId;
  int statusOrderId;
  int totalCost;
  DateTime createdAt;
  DateTime updatedAt;
  String? courierName;
  String name;
  String address;
  String status;

  Order({
    required this.id,
    required this.userId,
    required this.courierId,
    required this.statusOrderId,
    required this.totalCost,
    required this.createdAt,
    required this.updatedAt,
    required this.courierName,
    required this.name,
    required this.address,
    required this.status,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        userId: json["user_id"],
        courierId: json["courier_id"],
        statusOrderId: json["status_order_id"],
        totalCost: json["total_cost"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        courierName: json["courier_name"],
        name: json["name"],
        address: json["address"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "courier_id": courierId,
        "status_order_id": statusOrderId,
        "total_cost": totalCost,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "courier_name": courierName,
        "name": name,
        "address": address,
        "status": status,
      };
}
