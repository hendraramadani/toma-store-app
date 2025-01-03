import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:super_store_e_commerce_flutter/imports.dart';
import 'package:super_store_e_commerce_flutter/model/admin_courier.dart';
import 'package:super_store_e_commerce_flutter/model/courier_status_active.dart';

import 'package:super_store_e_commerce_flutter/model/product.dart';
import 'package:super_store_e_commerce_flutter/model/report.dart';
import 'package:super_store_e_commerce_flutter/model/admin_order.dart';
import 'package:super_store_e_commerce_flutter/model/admin_product.dart';
import 'package:super_store_e_commerce_flutter/model/courier_order.dart';
import 'package:super_store_e_commerce_flutter/model/user_order.dart';
import 'package:super_store_e_commerce_flutter/services/api_const.dart';
import 'package:super_store_e_commerce_flutter/model/login.dart';
// import 'package:super_store_e_commerce_flutter/services/persist.dart';
import 'package:shared_preferences/shared_preferences.dart';

///////////////////////////////// [/AUTH RESOURCE]
class LoginApiService {
  Future<List<LoginModel>?> login(email, password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var bodyFill = {"email": email, "password": password};
    var body = json.encode(bodyFill);
    try {
      // print(body);
      var url =
          Uri.parse(ApiConst.baseEndpoint + ApiConst.api + ApiConst.login);
      var response = await http
          .post(url, body: body, headers: {'Content-Type': 'application/json'});
      // print(response.body);

      if (response.statusCode == 200) {
        List<LoginModel> model = loginModelFromJson(response.body);

        prefs.setInt('id', model[0].data!.id);
        prefs.setString('token', model[0].accessToken);
        prefs.setInt('role', model[0].data!.roleId);
        prefs.setString('name', model[0].data!.name);
        prefs.setString('email', model[0].data!.email);
        prefs.setString('phone', model[0].data!.phone);
        if (model[0].data!.address == null) {
          prefs.setString('address', '');
          // print(prefs.getString('address').toString());
        } else {
          prefs.setString('address', model[0].data!.address);
          // print(prefs.getString('address').toString());
        }

        // print(prefs.getString('token').toString());
        // print(_model[0].accessToken);
        return model;
      } else if (response.statusCode == 401) {
        List<LoginModel> model = loginModelFromJson(response.body);
        // print(response.body);
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}

class RegisterApiService {
  Future<List<RegisterModel>?> register(
      name, email, phone, password, passwordConfirmation, roleId) async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    var bodyFill = {
      "name": name,
      "email": email,
      "phone": phone,
      "password": password,
      "password_confirmation": passwordConfirmation,
      "role_id": roleId
    };
    var body = json.encode(bodyFill);

    try {
      var url =
          Uri.parse(ApiConst.baseEndpoint + ApiConst.api + ApiConst.register);
      var response = await http
          .post(url, body: body, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 201) {
        print([response.statusCode, response.body]);
        List<RegisterModel> model = registerModelFromJson(response.body);

        print(model[0].data.email);
        return model;
      } else if (response.statusCode == 422) {
        //debug
        //Fail handler
        print([response.statusCode, response.body]);
        // return _model;
      } else if (response.statusCode == 500) {
        //debug
        //Fail handler
        print(response.statusCode);
        // return _model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}

class LogoutApiService {
  Future<void> logout() async {
    // print("masuk");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    print(token);

    try {
      var url =
          Uri.parse(ApiConst.baseEndpoint + ApiConst.api + ApiConst.logout);
      var response = await http.post(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });
      print(response.body);

      if (response.statusCode == 200) {
        prefs.remove('token');
        prefs.remove('role');
        prefs.remove('name');
        prefs.remove('email');
        prefs.remove('phone');
      } else {
        // List<LoginModel> _model = loginModelFromJson(response.body);
        print(response.body);
        // return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}

///////////////////////////////// [/USER RESOURCE]
class UserApiService {
  Future<List<ProfileModel>?> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();

    try {
      var url =
          Uri.parse(ApiConst.baseEndpoint + ApiConst.api + ApiConst.getuser);
      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode == 200) {
        print([response.statusCode, response.body]);
        List<ProfileModel> model = profileModelFromJson(response.body);

        // print(_model[0].data);
        return model;
      } else if (response.statusCode == 201) {
        print([response.statusCode, response.body]);
        List<ProfileModel> model = profileModelFromJson(response.body);

        // print(_model[0].data);
        return model;
      } else if (response.statusCode == 422) {
        //debug
        //Fail handler
        print([response.statusCode, response.body]);
        // return _model;
      } else if (response.statusCode == 500) {
        //debug
        //Fail handler
        print(response.statusCode);
        // return _model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<ProfileModel>?> updateUser(
      userId, userName, userPhone, userEmail, userAddress) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    var bodyFill = {
      "user_id": userId,
      "user_name": userName,
      "user_phone": userPhone,
      "user_email": userEmail,
      "user_address": userAddress,
    };
    var body = json.encode(bodyFill);
    try {
      var url =
          Uri.parse(ApiConst.baseEndpoint + ApiConst.api + ApiConst.updateuser);
      var response = await http.post(url, body: body, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode == 200) {
        print([response.statusCode, response.body]);
        List<ProfileModel> model = profileModelFromJson(response.body);

        // print(_model[0].data);
        return model;
      } else if (response.statusCode == 201) {
        print([response.statusCode, response.body]);
        List<ProfileModel> model = profileModelFromJson(response.body);

        // print(_model[0].data);
        return model;
      } else if (response.statusCode == 422) {
        //debug
        //Fail handler
        print([response.statusCode, response.body]);
        // return _model;
      } else if (response.statusCode == 500) {
        //debug
        //Fail handler
        print(response.statusCode);
        // return _model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}

///////////////////////////////// [/STORE RESOURCE]
class StoreApiService {
  Future<List<StoreModel>?> addStore(
      name, phone, address, image, latitude, longitude) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    print(token);
    var bodyFill = {
      "name": name,
      "phone": phone,
      "address": address,
      "image": base64Encode(image.readAsBytesSync()),
      "latitude": latitude,
      "longitude": longitude
    };
    var body = json.encode(bodyFill);

    try {
      var url =
          Uri.parse(ApiConst.baseEndpoint + ApiConst.api + ApiConst.addStore);
      var response = await http.post(url, body: body, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode == 201) {
        print([response.statusCode, response.body]);
        List<StoreModel> model = storeModelFromJson(response.body);

        // print(_model[0].data);
        return model;
      } else if (response.statusCode == 422) {
        //debug
        //Fail handler
        print([response.statusCode, response.body]);
        // return _model;
      } else if (response.statusCode == 500) {
        //debug
        //Fail handler
        print(response.statusCode);
        // return _model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<StoreModel>?> getStore() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();

    try {
      var url =
          Uri.parse(ApiConst.baseEndpoint + ApiConst.api + ApiConst.addStore);
      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode == 200) {
        print([response.statusCode, response.body]);
        List<StoreModel> model = storeModelFromJson(response.body);

        // print(_model[0].data);
        return model;
      } else if (response.statusCode == 201) {
        print([response.statusCode, response.body]);
        List<StoreModel> model = storeModelFromJson(response.body);

        // print(_model[0].data);
        return model;
      } else if (response.statusCode == 422) {
        //debug
        //Fail handler
        print([response.statusCode, response.body]);
        // return _model;
      } else if (response.statusCode == 500) {
        //debug
        //Fail handler
        print(response.statusCode);
        // return _model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<StoreModel>?> updateStore(id, name, phone, address) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    print(token);
    var bodyFill = {
      "name": name,
      "phone": phone,
      "address": address,
    };
    var body = json.encode(bodyFill);

    try {
      var url = Uri.parse(
          '${ApiConst.baseEndpoint}${ApiConst.api}${ApiConst.addStore}/$id');
      var response = await http.put(url, body: body, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode == 201) {
        print([response.statusCode, response.body]);
        List<StoreModel> model = storeModelFromJson(response.body);

        // print(_model[0].data);
        return model;
      } else if (response.statusCode == 422) {
        //debug
        //Fail handler
        print([response.statusCode, response.body]);
        // return _model;
      } else if (response.statusCode == 500) {
        //debug
        //Fail handler
        print(response.statusCode);
        // return _model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}

class GetStoreApiService {
  Future<List<StoreModel>?> getStore() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    print(token);

    try {
      var url =
          Uri.parse(ApiConst.baseEndpoint + ApiConst.api + ApiConst.addStore);
      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode == 200) {
        print([response.statusCode, response.body]);
        List<StoreModel> model = storeModelFromJson(response.body);
        // print(_model[0].data);
        return model;
      } else if (response.statusCode == 422) {
        //debug
        //Fail handler
        print([response.statusCode, response.body]);
        // return _model;
      } else if (response.statusCode == 500) {
        //debug
        //Fail handler
        print(response.statusCode);
        // return _model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}

///////////////////////////////// [/PRODUCT RESOURCE]
class ProductApiService {
  File? productFile;

  Future<List<ProductsModel>?> addProduct(name, stock, description, cost,
      productCategorieId, image, storeId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    print(token);
    var bodyFill = {
      "name": name,
      "stock": stock,
      "description": description,
      "cost": cost,
      "product_categorie_id": productCategorieId,
      "image": base64Encode(image.readAsBytesSync()),
      "store_id": storeId
    };
    var body = json.encode(bodyFill);
    try {
      var url =
          Uri.parse(ApiConst.baseEndpoint + ApiConst.api + ApiConst.product);
      var response = await http.post(url, body: body, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode == 201) {
        print([response.statusCode, response.body]);
        List<ProductsModel> model = productsModelFromJson(response.body);

        // print(_model[0].data);
        return model;
      } else if (response.statusCode == 422) {
        //debug
        //Fail handler
        print([response.statusCode, response.body]);
        // return _model;
      } else if (response.statusCode == 500) {
        //debug
        //Fail handler
        print(response.statusCode);
        // return _model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<AdminProductModel>?> getAdminProduct() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();

    try {
      var url =
          Uri.parse(ApiConst.baseEndpoint + ApiConst.api + ApiConst.product);
      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode == 200) {
        print([response.statusCode, response.body]);
        List<AdminProductModel> model =
            adminProductModelFromJson(response.body);

        // print(_model[0].data);
        return model;
      } else if (response.statusCode == 422) {
        //debug
        //Fail handler
        print([response.statusCode, response.body]);
        // return _model;
      } else if (response.statusCode == 500) {
        //debug
        //Fail handler
        print(response.statusCode);
        // return _model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<AdminProductModel>?> updateProduct(
      id, name, stock, description, cost, productCategorieId, storeId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    print(token);
    var bodyFill = {
      "name": name,
      "stock": stock,
      "description": description,
      "cost": cost,
      "product_categorie_id": productCategorieId,
      "store_id": storeId
    };
    var body = json.encode(bodyFill);
    try {
      var url = Uri.parse(
          '${ApiConst.baseEndpoint}${ApiConst.api}${ApiConst.product}/${id}');
      var response = await http.put(url, body: body, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode == 201) {
        print([response.statusCode, response.body]);
        List<AdminProductModel> model =
            adminProductModelFromJson(response.body);

        // print(_model[0].data);
        return model;
      } else if (response.statusCode == 422) {
        //debug
        //Fail handler
        print([response.statusCode, response.body]);
        // return _model;
      } else if (response.statusCode == 500) {
        //debug
        //Fail handler
        print(response.statusCode);
        // return _model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}

class GetProductCategoryApiService {
  Future<List<ProductCategoryModel>?> getProductCategory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    print(token);

    try {
      var url = Uri.parse(
          ApiConst.baseEndpoint + ApiConst.api + ApiConst.productCategory);
      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode == 200) {
        // print([response.statusCode, response.body]);
        List<ProductCategoryModel> model =
            productCategoryModelFromJson(response.body);
        // print(_model[0].data);
        return model;
      } else if (response.statusCode == 422) {
        //debug
        //Fail handler
        print([response.statusCode, response.body]);
        // return _model;
      } else if (response.statusCode == 500) {
        //debug
        //Fail handler
        print(response.statusCode);
        // return _model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}

///////////////////////////////// [/COURIER RESOURCE]
class CourierApiService {
  Future<List<AdminCourierModel>?> getAdminCourier() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();

    try {
      var url =
          Uri.parse(ApiConst.baseEndpoint + ApiConst.api + ApiConst.courier);
      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode == 200) {
        print([response.statusCode, response.body]);
        List<AdminCourierModel> model =
            adminCourierModelFromJson(response.body);
        // print(_model[0].data);
        return model;
      } else if (response.statusCode == 422) {
        //debug
        //Fail handler
        print([response.statusCode, response.body]);
        // return _model;
      } else if (response.statusCode == 500) {
        //debug
        //Fail handler
        print(response.statusCode);
        // return _model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<CourierStatusActiveModel>?> getCourierStatusActive() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();

    try {
      var url = Uri.parse(
          ApiConst.baseEndpoint + ApiConst.api + ApiConst.courierstatusactive);
      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode == 200) {
        print([response.statusCode, response.body]);
        List<CourierStatusActiveModel> model =
            courierStatusActiveModelFromJson(response.body);
        // print(_model[0].data);
        return model;
      } else if (response.statusCode == 422) {
        //debug
        //Fail handler
        print([response.statusCode, response.body]);
        // return _model;
      } else if (response.statusCode == 500) {
        //debug
        //Fail handler
        print(response.statusCode);
        // return _model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<AdminCourierModel>?> updateAdminCourier(
    courierId,
    userId,
    statusAvailableId,
    courierName,
    courierPhone,
    courierEmail,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    var bodyFill = {
      "courier_id": courierId,
      "user_id": userId,
      "status_available_id": statusAvailableId,
      "courier_name": courierName,
      "courier_phone": courierPhone,
      "courier_email": courierEmail
    };
    var body = json.encode(bodyFill);
    try {
      var url = Uri.parse(
          ApiConst.baseEndpoint + ApiConst.api + ApiConst.updatecourier);
      var response = await http.post(url, body: body, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode == 200) {
        print([response.statusCode, response.body]);
        List<AdminCourierModel> model =
            adminCourierModelFromJson(response.body);
        // print(_model[0].data);
        return model;
      } else if (response.statusCode == 201) {
        print([response.statusCode, response.body]);
        List<AdminCourierModel> model =
            adminCourierModelFromJson(response.body);
        // print(_model[0].data);
        return model;
      } else if (response.statusCode == 422) {
        //debug
        //Fail handler
        print([response.statusCode, response.body]);
        // return _model;
      } else if (response.statusCode == 500) {
        //debug
        //Fail handler
        print(response.statusCode);
        // return _model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<CourierModel>?> getCourier() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getInt('id');
    String token = prefs.getString('token').toString();
    print(id);
    var bodyFill = {
      "user_id": id,
    };
    var body = json.encode(bodyFill);
    try {
      var url =
          Uri.parse(ApiConst.baseEndpoint + ApiConst.api + ApiConst.getcourier);
      var response = await http.post(url, body: body, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode == 200) {
        print([response.statusCode, response.body]);
        List<CourierModel> model = courierModelFromJson(response.body);
        // print(_model[0].data);
        return model;
      } else if (response.statusCode == 422) {
        //debug
        //Fail handler
        print([response.statusCode, response.body]);
        // return _model;
      } else if (response.statusCode == 500) {
        //debug
        //Fail handler
        print(response.statusCode);
        // return _model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<CourierModel>?> updateCourierStatus(int statusId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getInt('id');
    String token = prefs.getString('token').toString();
    var bodyFill = {"user_id": id, "courier_status_available_id": statusId};
    var body = json.encode(bodyFill);
    try {
      var url = Uri.parse(ApiConst.baseEndpoint +
          ApiConst.api +
          ApiConst.updatestatusavailablecourier);
      var response = await http.post(url, body: body, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode == 200) {
        print([response.statusCode, response.body]);

        // print(_model[0].data);
      } else if (response.statusCode == 201) {
        //debug
        //Fail handler
        print([response.statusCode, response.body]);
        // return _model;
      } else if (response.statusCode == 422) {
        //debug
        //Fail handler
        print([response.statusCode, response.body]);
        // return _model;
      } else if (response.statusCode == 500) {
        //debug
        //Fail handler
        print(response.statusCode);
        // return _model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<CourierOrderModel>?> getListAllCourierOrder() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();

    try {
      var url = Uri.parse(ApiConst.baseEndpoint +
          ApiConst.api +
          ApiConst.getlistallordercourier);
      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode == 201) {
        print([response.statusCode, response.body]);
        List<CourierOrderModel> model =
            courierOrderModelFromJson(response.body);

        // print(_model[0].data);
        return model;
      } else if (response.statusCode == 200) {
        print([response.statusCode, response.body]);
        List<CourierOrderModel> model =
            courierOrderModelFromJson(response.body);

        // print(_model[0].data);
        return model;
      } else if (response.statusCode == 422) {
        //debug
        //Fail handler
        print([response.statusCode, response.body]);
        // return _model;
      } else if (response.statusCode == 500) {
        //debug
        //Fail handler
        print(response.statusCode);
        // return _model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<void> assignOrderCourier(orderId, courierId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();

    var bodyFill = {"order_id": orderId, "courier_id": courierId};
    var body = json.encode(bodyFill);

    try {
      var url = Uri.parse(
          ApiConst.baseEndpoint + ApiConst.api + ApiConst.assignordercourier);
      var response = await http.post(url, body: body, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode == 201) {
        print([response.statusCode, response.body]);
      } else if (response.statusCode == 200) {
        print([response.statusCode, response.body]);
      } else if (response.statusCode == 422) {
        //debug
        //Fail handler
        print([response.statusCode, response.body]);
        // return _model;
      } else if (response.statusCode == 500) {
        //debug
        //Fail handler
        print(response.statusCode);
        // return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<CourierOrderModel>?> getListTakenCourierOrder() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    var courierId = prefs.getInt('courier_id');
    var bodyFill = {"courier_id": courierId};
    var body = json.encode(bodyFill);

    try {
      var url = Uri.parse(ApiConst.baseEndpoint +
          ApiConst.api +
          ApiConst.takenlistordercourier);
      var response = await http.post(url, body: body, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode == 201) {
        print([response.statusCode, response.body]);
        List<CourierOrderModel> model =
            courierOrderModelFromJson(response.body);

        // print(_model[0].data);
        return model;
      } else if (response.statusCode == 200) {
        print([response.statusCode, response.body]);
        List<CourierOrderModel> model =
            courierOrderModelFromJson(response.body);

        // print(_model[0].data);
        return model;
      } else if (response.statusCode == 422) {
        //debug
        //Fail handler
        print([response.statusCode, response.body]);
        // return _model;
      } else if (response.statusCode == 500) {
        //debug
        //Fail handler
        print(response.statusCode);
        // return _model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<void> deliverOrderCourier(orderId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();

    var bodyFill = {"order_id": orderId};
    var body = json.encode(bodyFill);

    try {
      var url = Uri.parse(
          ApiConst.baseEndpoint + ApiConst.api + ApiConst.deliverordercourier);
      var response = await http.post(url, body: body, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode == 201) {
        print([response.statusCode, response.body]);
      } else if (response.statusCode == 200) {
        print([response.statusCode, response.body]);
      } else if (response.statusCode == 422) {
        //debug
        //Fail handler
        print([response.statusCode, response.body]);
        // return _model;
      } else if (response.statusCode == 500) {
        //debug
        //Fail handler
        print(response.statusCode);
        // return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> cancelOrderCourier(orderId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();

    var bodyFill = {"order_id": orderId};
    var body = json.encode(bodyFill);

    try {
      var url = Uri.parse(
          ApiConst.baseEndpoint + ApiConst.api + ApiConst.cancelordercourier);
      var response = await http.post(url, body: body, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode == 201) {
        print([response.statusCode, response.body]);
      } else if (response.statusCode == 200) {
        print([response.statusCode, response.body]);
      } else if (response.statusCode == 422) {
        //debug
        //Fail handler
        print([response.statusCode, response.body]);
        // return _model;
      } else if (response.statusCode == 500) {
        //debug
        //Fail handler
        print(response.statusCode);
        // return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<CourierOrderModel>?> getListDoneCourierOrder() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    var courierId = prefs.getInt('courier_id');
    var bodyFill = {"courier_id": courierId};
    var body = json.encode(bodyFill);

    try {
      var url = Uri.parse(
          ApiConst.baseEndpoint + ApiConst.api + ApiConst.donelistordercourier);
      var response = await http.post(url, body: body, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode == 201) {
        print([response.statusCode, response.body]);
        List<CourierOrderModel> model =
            courierOrderModelFromJson(response.body);

        // print(_model[0].data);
        return model;
      } else if (response.statusCode == 200) {
        print([response.statusCode, response.body]);
        List<CourierOrderModel> model =
            courierOrderModelFromJson(response.body);

        // print(_model[0].data);
        return model;
      } else if (response.statusCode == 422) {
        //debug
        //Fail handler
        print([response.statusCode, response.body]);
        // return _model;
      } else if (response.statusCode == 500) {
        //debug
        //Fail handler
        print(response.statusCode);
        // return _model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}

///////////////////////////////// [/CART RESOURCE]
class CartApiService {
  Future<List<CartModel>?> cart(id, data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    print(token);
    var bodyFill = {
      "user_id": id,
      "data": data,
    };
    var body = json.encode(bodyFill);

    try {
      var url = Uri.parse(ApiConst.baseEndpoint + ApiConst.api + ApiConst.cart);
      var response = await http.post(url, body: body, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode == 201) {
        print([response.statusCode, response.body]);
        List<CartModel> model = cartModelFromJson(response.body);

        // print(_model[0].data);
        return model;
      } else if (response.statusCode == 200) {
        print([response.statusCode, response.body]);
        List<CartModel> model = cartModelFromJson(response.body);

        // print(_model[0].data);
        return model;
      } else if (response.statusCode == 422) {
        //debug
        //Fail handler
        print([response.statusCode, response.body]);
        // return _model;
      } else if (response.statusCode == 500) {
        //debug
        //Fail handler
        print(response.statusCode);
        // return _model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<CartModel>?> getCart(id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    print(token);
    var bodyFill = {
      "user_id": id,
    };
    var body = json.encode(bodyFill);

    try {
      var url =
          Uri.parse(ApiConst.baseEndpoint + ApiConst.api + ApiConst.getCart);
      var response = await http.post(url, body: body, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode == 200) {
        print([response.statusCode, response.body]);
        List<CartModel> model = cartModelFromJson(response.body);

        // print(_model[0].data);
        return model;
      } else if (response.statusCode == 422) {
        //debug
        //Fail handler
        print([response.statusCode, response.body]);
        // return _model;
      } else if (response.statusCode == 500) {
        //debug
        //Fail handler
        print(response.statusCode);
        // return _model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}

///////////////////////////////// [/Order RESOURCE]
class OrderApiService {
  Future<List<InvoiceModel>?> storeOrder(id, data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    print(token);
    var bodyFill = {
      "user_id": id,
      "data": data,
    };
    var body = json.encode(bodyFill);

    try {
      var url =
          Uri.parse(ApiConst.baseEndpoint + ApiConst.api + ApiConst.order);
      var response = await http.post(url, body: body, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode == 201) {
        print([response.statusCode, response.body]);
        List<InvoiceModel> model = invoiceModelFromJson(response.body);

        // print(_model[0].data);
        return model;
      } else if (response.statusCode == 200) {
        print([response.statusCode, response.body]);
        List<InvoiceModel> model = invoiceModelFromJson(response.body);

        // print(_model[0].data);
        return model;
      } else if (response.statusCode == 422) {
        //debug
        //Fail handler
        print([response.statusCode, response.body]);
        // return _model;
      } else if (response.statusCode == 500) {
        //debug
        //Fail handler
        print(response.statusCode);
        // return _model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<UserOrderModel>?> getUserOrder() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    var id = prefs.getInt('id');
    print(id);
    var bodyFill = {
      "user_id": id,
    };
    var body = json.encode(bodyFill);

    try {
      var url = Uri.parse(
          ApiConst.baseEndpoint + ApiConst.api + ApiConst.getUserOrder);
      var response = await http.post(url, body: body, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode == 201) {
        print([response.statusCode, response.body]);
        List<UserOrderModel> model = userOrderModelFromJson(response.body);

        // print(_model[0].data);
        return model;
      } else if (response.statusCode == 200) {
        print([response.statusCode, response.body]);
        List<UserOrderModel> model = userOrderModelFromJson(response.body);

        // print(_model[0].data);
        return model;
      } else if (response.statusCode == 422) {
        //debug
        //Fail handler
        print([response.statusCode, response.body]);
        // return _model;
      } else if (response.statusCode == 500) {
        //debug
        //Fail handler
        print(response.statusCode);
        // return _model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<AdminOrderModel>?> getAdminOrder() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    var id = prefs.getInt('id');
    print(id);
    // var body_fill = {
    //   "user_id": id,
    // };
    // var body = json.encode(body_fill);

    try {
      var url = Uri.parse(
          ApiConst.baseEndpoint + ApiConst.api + ApiConst.getAdminOrder);
      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode == 201) {
        print([response.statusCode, response.body]);
        List<AdminOrderModel> model = adminOrderModelFromJson(response.body);

        // print(_model[0].data);
        return model;
      } else if (response.statusCode == 200) {
        print([response.statusCode, response.body]);
        List<AdminOrderModel> model = adminOrderModelFromJson(response.body);

        // print(_model[0].data);
        return model;
      } else if (response.statusCode == 422) {
        //debug
        //Fail handler
        print([response.statusCode, response.body]);
        // return _model;
      } else if (response.statusCode == 500) {
        //debug
        //Fail handler
        print(response.statusCode);
        // return _model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<void> doneOrderUser(orderId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    print(orderId);
    var bodyFill = {"order_id": orderId};
    var body = json.encode(bodyFill);

    try {
      var url = Uri.parse(
          ApiConst.baseEndpoint + ApiConst.api + ApiConst.doneUserOrder);
      var response = await http.post(url, body: body, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });
      if (response.statusCode == 201) {
        print([response.statusCode, response.body]);
      } else if (response.statusCode == 200) {
        print([response.statusCode, response.body]);
      } else if (response.statusCode == 422) {
        //debug
        //Fail handler
        print([response.statusCode, response.body]);
        // return _model;
      } else if (response.statusCode == 500) {
        //debug
        //Fail handler
        print(response.statusCode);
        // return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> cancelOrderUser(orderId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    print(orderId);
    var bodyFill = {"order_id": orderId};
    var body = json.encode(bodyFill);

    try {
      var url = Uri.parse(
          ApiConst.baseEndpoint + ApiConst.api + ApiConst.cancelUserOrder);
      var response = await http.post(url, body: body, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });
      if (response.statusCode == 201) {
        print([response.statusCode, response.body]);
      } else if (response.statusCode == 200) {
        print([response.statusCode, response.body]);
      } else if (response.statusCode == 422) {
        //debug
        //Fail handler
        print([response.statusCode, response.body]);
        // return _model;
      } else if (response.statusCode == 500) {
        //debug
        //Fail handler
        print(response.statusCode);
        // return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}

///////////////////////////////// [/Profile RESOURCE]

class ProfileApiService {
  Future<List<ProfileModel>?> getUserProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getInt('id');
    String token = prefs.getString('token').toString();
    print(token);
    var bodyFill = {
      "user_id": id,
    };
    var body = json.encode(bodyFill);

    try {
      var url = Uri.parse(
          ApiConst.baseEndpoint + ApiConst.api + ApiConst.getUserProfile);
      var response = await http.post(url, body: body, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });

      print(response.statusCode);
      if (response.statusCode == 201) {
        print([response.statusCode, response.body]);
        List<ProfileModel> model = profileModelFromJson(response.body);

        // print(_model[0].data);
        return model;
      } else if (response.statusCode == 200) {
        print([response.statusCode, response.body]);
        List<ProfileModel> model = profileModelFromJson(response.body);

        // print(_model[0].data);
        return model;
      } else if (response.statusCode == 422) {
        //debug
        //Fail handler
        print([response.statusCode, response.body]);
        // return _model;
      } else if (response.statusCode == 500) {
        //debug
        //Fail handler
        print(response.statusCode);
        // return _model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<ProfileModel>?> updateUserAddress(userAddress) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getInt('id');
    String token = prefs.getString('token').toString();
    print(token);
    var bodyFill = {"user_id": id, "user_address": userAddress};
    var body = json.encode(bodyFill);

    try {
      var url = Uri.parse(
          ApiConst.baseEndpoint + ApiConst.api + ApiConst.updateUserAddress);
      var response = await http.post(url, body: body, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });

      print(response.statusCode);
      if (response.statusCode == 201) {
        print([response.statusCode, response.body]);
        List<ProfileModel> model = profileModelFromJson(response.body);

        // print(_model[0].data);
        return model;
      } else if (response.statusCode == 200) {
        print([response.statusCode, response.body]);
        List<ProfileModel> model = profileModelFromJson(response.body);

        // print(_model[0].data);
        return model;
      } else if (response.statusCode == 422) {
        //debug
        //Fail handler
        print([response.statusCode, response.body]);
        // return _model;
      } else if (response.statusCode == 500) {
        //debug
        //Fail handler
        print(response.statusCode);
        // return _model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}

///////////////////////////////// [/Report RESOURCE]
class ReportApiService {
  Future<List<ReportModel>?> getReportAllUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    print(token);

    try {
      var url = Uri.parse(
          ApiConst.baseEndpoint + ApiConst.api + ApiConst.reportuserall);
      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode == 200) {
        print([response.statusCode, response.body]);
        List<ReportModel> model = reportModelFromJson(response.body);
        // print(_model[0].data);
        return model;
      } else if (response.statusCode == 422) {
        //debug
        //Fail handler
        print([response.statusCode, response.body]);
        // return _model;
      } else if (response.statusCode == 500) {
        //debug
        //Fail handler
        print(response.statusCode);
        // return _model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<ReportModel>?> getReportAllCourier() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    print(token);

    try {
      var url = Uri.parse(
          ApiConst.baseEndpoint + ApiConst.api + ApiConst.reportcourierall);
      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode == 200) {
        print([response.statusCode, response.body]);
        List<ReportModel> model = reportModelFromJson(response.body);
        // print(_model[0].data);
        return model;
      } else if (response.statusCode == 422) {
        //debug
        //Fail handler
        print([response.statusCode, response.body]);
        // return _model;
      } else if (response.statusCode == 500) {
        //debug
        //Fail handler
        print(response.statusCode);
        // return _model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<ReportModel>?> getReportAllOrder() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    print(token);

    try {
      var url = Uri.parse(
          ApiConst.baseEndpoint + ApiConst.api + ApiConst.reportorderall);
      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode == 200) {
        print([response.statusCode, response.body]);
        List<ReportModel> model = reportModelFromJson(response.body);
        // print(_model[0].data);
        return model;
      } else if (response.statusCode == 422) {
        //debug
        //Fail handler
        print([response.statusCode, response.body]);
        // return _model;
      } else if (response.statusCode == 500) {
        //debug
        //Fail handler
        print(response.statusCode);
        // return _model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<ReportModel>?> getReportAllSuccessOrder() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    print(token);

    try {
      var url = Uri.parse(ApiConst.baseEndpoint +
          ApiConst.api +
          ApiConst.reportrecapallsuccessorder);
      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode == 200) {
        print([response.statusCode, response.body]);
        List<ReportModel> model = reportModelFromJson(response.body);
        // print(_model[0].data);
        return model;
      } else if (response.statusCode == 422) {
        //debug
        //Fail handler
        print([response.statusCode, response.body]);
        // return _model;
      } else if (response.statusCode == 500) {
        //debug
        //Fail handler
        print(response.statusCode);
        // return _model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<ReportModel>?> getReportAllCancelOrder() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    print(token);

    try {
      var url = Uri.parse(ApiConst.baseEndpoint +
          ApiConst.api +
          ApiConst.reportrecapallcancelledorder);
      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode == 200) {
        print([response.statusCode, response.body]);
        List<ReportModel> model = reportModelFromJson(response.body);
        // print(_model[0].data);
        return model;
      } else if (response.statusCode == 422) {
        //debug
        //Fail handler
        print([response.statusCode, response.body]);
        // return _model;
      } else if (response.statusCode == 500) {
        //debug
        //Fail handler
        print(response.statusCode);
        // return _model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<ReportModel>?> getReportAllSuccessOrderbyDate(
      startDate, endDate) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    print(token);
    var bodyFill = {
      "start_date": startDate.toString(),
      "end_date": endDate.toString(),
    };
    var body = json.encode(bodyFill);

    try {
      var url = Uri.parse(ApiConst.baseEndpoint +
          ApiConst.api +
          ApiConst.reportrecapsuccessbydate);
      var response = await http.post(url, body: body, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode == 200) {
        print([response.statusCode, response.body]);
        List<ReportModel> model = reportModelFromJson(response.body);
        // print(_model[0].data);
        return model;
      } else if (response.statusCode == 422) {
        //debug
        //Fail handler
        print([response.statusCode, response.body]);
        // return _model;
      } else if (response.statusCode == 500) {
        //debug
        //Fail handler
        print(response.statusCode);
        // return _model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<ReportModel>?> getReportAllCancelOrderbyDate(
      startDate, endDate) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    print(token);
    var bodyFill = {
      "start_date": startDate.toString(),
      "end_date": endDate.toString(),
    };
    var body = json.encode(bodyFill);
    try {
      var url = Uri.parse(ApiConst.baseEndpoint +
          ApiConst.api +
          ApiConst.reportrecapcancelledbydate);
      var response = await http.post(url, body: body, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode == 200) {
        print([response.statusCode, response.body]);
        List<ReportModel> model = reportModelFromJson(response.body);
        // print(_model[0].data);
        return model;
      } else if (response.statusCode == 422) {
        //debug
        //Fail handler
        print([response.statusCode, response.body]);
        // return _model;
      } else if (response.statusCode == 500) {
        //debug
        //Fail handler
        print(response.statusCode);
        // return _model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<ReportModel>?> getReportAllStore() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    print(token);

    try {
      var url = Uri.parse(
          ApiConst.baseEndpoint + ApiConst.api + ApiConst.reportstoreall);
      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode == 200) {
        print([response.statusCode, response.body]);
        List<ReportModel> model = reportModelFromJson(response.body);
        // print(_model[0].data);
        return model;
      } else if (response.statusCode == 422) {
        //debug
        //Fail handler
        print([response.statusCode, response.body]);
        // return _model;
      } else if (response.statusCode == 500) {
        //debug
        //Fail handler
        print(response.statusCode);
        // return _model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<ReportModel>?> getReportAllProduct() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    print(token);

    try {
      var url = Uri.parse(
          ApiConst.baseEndpoint + ApiConst.api + ApiConst.reportproductall);
      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode == 200) {
        print([response.statusCode, response.body]);
        List<ReportModel> model = reportModelFromJson(response.body);
        // print(_model[0].data);
        return model;
      } else if (response.statusCode == 422) {
        //debug
        //Fail handler
        print([response.statusCode, response.body]);
        // return _model;
      } else if (response.statusCode == 500) {
        //debug
        //Fail handler
        print(response.statusCode);
        // return _model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
