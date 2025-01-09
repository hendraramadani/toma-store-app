// To parse this JSON data, do
//
//     final courierOrderModel = courierOrderModelFromJson(jsonString);

import 'dart:convert';

List<CourierOrderModel> courierOrderModelFromJson(String str) =>
    List<CourierOrderModel>.from(
        json.decode(str).map((x) => CourierOrderModel.fromJson(x)));

String courierOrderModelToJson(List<CourierOrderModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CourierOrderModel {
  Order order;
  List<Detail> detail;

  CourierOrderModel({
    required this.order,
    required this.detail,
  });

  factory CourierOrderModel.fromJson(Map<String, dynamic> json) =>
      CourierOrderModel(
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
  String storeName;
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
    required this.storeName,
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
        storeName: json["store_name"],
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
        "store_name": storeName,
        "product_image": productImage,
      };
}

class Order {
  int id;
  int userId;
  dynamic courierId;
  int statusOrderId;
  int totalCost;
  DateTime createdAt;
  DateTime updatedAt;
  String name;
  String phone;
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
    required this.name,
    required this.phone,
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
        name: json["name"],
        phone: json["user_phone"],
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
        "name": name,
        "user_phone": phone,
        "address": address,
        "status": status,
      };
}
