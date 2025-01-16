// To parse this JSON data, do
//
//     final adminProductModel = adminProductModelFromJson(jsonString);

import 'dart:convert';

List<AdminProductModel> adminProductModelFromJson(String str) =>
    List<AdminProductModel>.from(
        json.decode(str).map((x) => AdminProductModel.fromJson(x)));

String adminProductModelToJson(List<AdminProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AdminProductModel {
  int id;
  String name;
  dynamic stock;
  String description;
  dynamic cost;
  int productCategorieId;
  String image;
  int storeId;
  DateTime createdAt;
  DateTime updatedAt;
  String? productCategorieName;
  String? storeName;

  AdminProductModel({
    required this.id,
    required this.name,
    required this.stock,
    required this.description,
    required this.cost,
    required this.productCategorieId,
    required this.image,
    required this.storeId,
    required this.createdAt,
    required this.updatedAt,
    required this.productCategorieName,
    required this.storeName,
  });

  factory AdminProductModel.fromJson(Map<String, dynamic> json) =>
      AdminProductModel(
        id: json["id"],
        name: json["name"],
        stock: json["stock"],
        description: json["description"],
        cost: json["cost"],
        productCategorieId: json["product_categorie_id"],
        image: json["image"],
        storeId: json["store_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        productCategorieName: json["product_categorie_name"],
        storeName: json["store_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "stock": stock,
        "description": description,
        "cost": cost,
        "product_categorie_id": productCategorieId,
        "image": image,
        "store_id": storeId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "product_categorie_name": productCategorieName,
        "store_name": storeName,
      };
}
