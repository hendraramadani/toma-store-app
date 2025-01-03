// To parse this JSON data, do
//
//     final productsModel = productsModelFromJson(jsonString);

import 'dart:convert';

List<ProductsModel> productsModelFromJson(String str) =>
    List<ProductsModel>.from(
        json.decode(str).map((x) => ProductsModel.fromJson(x)));

String productsModelToJson(List<ProductsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductsModel {
  bool status;
  String message;
  Data data;

  ProductsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  String name;
  int stock;
  String description;
  int cost;
  int productCategorieId;
  dynamic image;
  int storeId;
  int id;

  Data({
    required this.name,
    required this.stock,
    required this.description,
    required this.cost,
    required this.productCategorieId,
    required this.image,
    required this.storeId,
    required this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        stock: json["stock"],
        description: json["description"],
        cost: json["cost"],
        productCategorieId: json["product_categorie_id"],
        image: json["image"],
        storeId: json["store_id"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "stock": stock,
        "description": description,
        "cost": cost,
        "product_categorie_id": productCategorieId,
        "image": image,
        "store_id": storeId,
        "id": id,
      };
}
