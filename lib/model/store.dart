import 'dart:convert';

List<StoreModel> storeModelFromJson(String str) =>
    List<StoreModel>.from(json.decode(str).map((x) => StoreModel.fromJson(x)));

String storeModelToJson(List<StoreModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StoreModel {
  int id;
  String name;
  String phone;
  String address;
  String image;
  String latitude;
  String longitude;

  StoreModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.image,
    required this.latitude,
    required this.longitude,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) => StoreModel(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        address: json["address"],
        image: json["image"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "address": address,
        "image": image,
        "latitude": latitude,
        "longitude": longitude,
      };

  static List<StoreModel> fromJsonList(List list) {
    return list.map((item) => StoreModel.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#$id $name';
  }

  ///this method will prevent the override of toString

  ///custom comparing function to check if two users are equal
  bool isEqual(StoreModel model) {
    return id == model.id;
  }

  @override
  String toString() => name;
}
