import 'dart:convert';

List<RegisterModel> registerModelFromJson(String str) =>
    List<RegisterModel>.from(
        json.decode(str).map((x) => RegisterModel.fromJson(x)));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  bool success;
  String msg;
  String accessToken;
  String tokenType;
  Data data;

  RegisterModel({
    required this.success,
    required this.msg,
    required this.accessToken,
    required this.tokenType,
    required this.data,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
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
        "data": data.toJson(),
      };
}

class Data {
  int id;
  String name;
  String email;
  String phone;
  int roleId;

  Data({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.roleId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        roleId: json["role_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "role_id": roleId,
      };
}
