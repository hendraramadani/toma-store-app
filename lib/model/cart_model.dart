import 'dart:convert';

List<CartModel> cartModelFromJson(String str) =>
    List<CartModel>.from(json.decode(str).map((x) => CartModel.fromJson(x)));
String cartModelToJson(List<CartModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CartModel {
  int? id;
  int? quantity;
  dynamic totalPrice;
  String? title;
  dynamic price;
  String? category;
  String? store;
  String? image;
  int? productId;

  CartModel(
      {this.id,
      this.quantity,
      this.totalPrice,
      this.title,
      this.price,
      this.category,
      this.store,
      this.image,
      this.productId});

  CartModel copyWith(
      {int? id,
      int? quantity,
      dynamic totalPrice,
      String? title,
      dynamic price,
      String? category,
      String? store,
      String? image,
      int? productId}) {
    return CartModel(
        id: id ?? this.id,
        quantity: quantity ?? this.quantity,
        totalPrice: totalPrice ?? this.totalPrice,
        title: title ?? this.title,
        price: price ?? this.price,
        category: category ?? this.category,
        store: store ?? this.store,
        image: image ?? this.image,
        productId: productId ?? this.productId);
  }

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
        id: json['id'],
        quantity: json['quantity'],
        totalPrice: json['totalPrice'],
        title: json['title'],
        price: json['price'],
        category: json['category'],
        store: json['store'],
        image: json['image'],
        productId: json['product_id']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['quantity'] = quantity;
    data['totalPrice'] = totalPrice;
    data['title'] = title;
    data['price'] = price;
    data['category'] = category;
    data['store'] = store;
    data['image'] = image;
    data['product_id'] = productId;
    return data;
  }
}
