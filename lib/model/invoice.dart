// To parse this JSON data, do
//
//     final invoiceModel = invoiceModelFromJson(jsonString);

import 'dart:convert';

List<InvoiceModel> invoiceModelFromJson(String str) => List<InvoiceModel>.from(
    json.decode(str).map((x) => InvoiceModel.fromJson(x)));

String invoiceModelToJson(List<InvoiceModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InvoiceModel {
  Order order;
  List<Detail> detail;

  InvoiceModel({
    required this.order,
    required this.detail,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) => InvoiceModel(
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
  String image;
  int price;
  String store;
  String title;
  String category;
  int quantity;
  int productId;
  int totalPrice;

  Detail({
    required this.id,
    required this.image,
    required this.price,
    required this.store,
    required this.title,
    required this.category,
    required this.quantity,
    required this.productId,
    required this.totalPrice,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"],
        image: json["image"],
        price: json["price"],
        store: json["store"],
        title: json["title"],
        category: json["category"],
        quantity: json["quantity"],
        productId: json["product_id"],
        totalPrice: json["totalPrice"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "price": price,
        "store": store,
        "title": title,
        "category": category,
        "quantity": quantity,
        "product_id": productId,
        "totalPrice": totalPrice,
      };
}

class Order {
  int userId;
  int statusOrderId;
  int totalCost;
  DateTime updatedAt;
  DateTime createdAt;
  int id;
  String name;

  Order({
    required this.userId,
    required this.statusOrderId,
    required this.totalCost,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
    required this.name,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        userId: json["user_id"],
        statusOrderId: json["status_order_id"],
        totalCost: json["total_cost"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "status_order_id": statusOrderId,
        "total_cost": totalCost,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
        "name": name,
      };
}
