// To parse this JSON data, do
//
//     final userOrderModel = userOrderModelFromJson(jsonString);

import 'dart:convert';

List<UserOrderModel> userOrderModelFromJson(String str) =>
    List<UserOrderModel>.from(
        json.decode(str).map((x) => UserOrderModel.fromJson(x)));

String userOrderModelToJson(List<UserOrderModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserOrderModel {
  Order order;
  List<Detail> detail;

  UserOrderModel({
    required this.order,
    required this.detail,
  });

  factory UserOrderModel.fromJson(Map<String, dynamic> json) => UserOrderModel(
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
  dynamic courierName;
  dynamic courierPhone;
  int statusOrderId;
  int totalCost;
  DateTime createdAt;
  DateTime updatedAt;
  String name;
  String address;
  String status;
  dynamic image;

  Order({
    required this.id,
    required this.userId,
    required this.courierId,
    required this.courierName,
    required this.courierPhone,
    required this.statusOrderId,
    required this.totalCost,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.address,
    required this.status,
    required this.image,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        userId: json["user_id"],
        courierId: json["courier_id"],
        courierName: json["courier_name"],
        courierPhone: json["courier_phone"],
        statusOrderId: json["status_order_id"],
        totalCost: json["total_cost"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        name: json["name"],
        address: json["address"],
        status: json["status"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "courier_id": courierId,
        "courier_name": courierName,
        "courier_phone": courierPhone,
        "status_order_id": statusOrderId,
        "total_cost": totalCost,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "name": name,
        "address": address,
        "status": status,
        "image": image,
      };
}
