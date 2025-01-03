import 'dart:convert';

List<ProductCategoryModel> productCategoryModelFromJson(String str) =>
    List<ProductCategoryModel>.from(
        json.decode(str).map((x) => ProductCategoryModel.fromJson(x)));

String productCategoryModelToJson(List<ProductCategoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductCategoryModel {
  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;

  ProductCategoryModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductCategoryModel.fromJson(Map<String, dynamic> json) =>
      ProductCategoryModel(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
  static List<ProductCategoryModel> fromJsonList(List list) {
    return list.map((item) => ProductCategoryModel.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#$id $name';
  }

  ///this method will prevent the override of toString

  ///custom comparing function to check if two users are equal
  bool isEqual(ProductCategoryModel model) {
    return id == model.id;
  }

  @override
  String toString() => name;
}
