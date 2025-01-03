import 'dart:convert';

List<LoginModel> loginModelFromJson(String str) =>
    List<LoginModel>.from(json.decode(str).map((x) => LoginModel.fromJson(x)));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  bool success;
  String msg;
  String accessToken;
  String tokenType;
  Data? data;

  LoginModel({
    required this.success,
    required this.msg,
    required this.accessToken,
    required this.tokenType,
    required this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        success: json["success"],
        msg: json["msg"],
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "msg": msg,
        "access_token": accessToken,
        "token_type": tokenType,
        "data": data?.toJson(),
      };
}

class Data {
  int id;
  String name;
  String email;
  String phone;
  dynamic address;
  int roleId;

  Data({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.roleId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        roleId: json["role_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "address": address,
        "role_id": roleId,
      };
}
