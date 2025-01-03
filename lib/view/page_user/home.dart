import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:super_store_e_commerce_flutter/imports.dart';
import 'package:super_store_e_commerce_flutter/services/api_const.dart';

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<UserHome> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController editingController = TextEditingController();
  Future<List<ProductModel>>? futureProduct;

  ///
  Future<List<ProductModel>>? items;
  String selectedValue = '1';
  String searchString = "";

  Future<List<ProductModel>> fetchProducts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    List<ProductModel> products = [];
    var url =
        Uri.parse(ApiConst.baseEndpoint + ApiConst.api + ApiConst.productuser);
    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    }); // Store the response body

    if (response.statusCode == 200) {
      if (kDebugMode) {
        // print(response.body);
      }
      final jsonData = jsonDecode(response.body);
      products =
          jsonData.map<ProductModel>((e) => ProductModel.fromJson(e)).toList();
      setState(() {}); // Assuming this is within a Stateful widget

      return products;
    } else {
      if (kDebugMode) {
        print(response.reasonPhrase);
      }
      return [];
    }
  }

  @override
  void initState() => {
        super.initState(),
        context.read<CartProvider>().cartData(),
        futureProduct = fetchProducts(),
        WidgetsBinding.instance.addPostFrameCallback((_) {}),
        Future.delayed(const Duration(seconds: 3)).then((value) => setState(() {
              // items = futureProduct;
            }))
      };

  List<ProductModel> newData = [];
  List<ProductModel> filterSearch(AsyncSnapshot<List<ProductModel>> query) {
    newData = query.data!
        .where((item) =>
            item.title!.toLowerCase().contains(searchString.toLowerCase()) ||
            item.store!.toLowerCase().contains(searchString.toLowerCase()) ||
            item.category!.toLowerCase().contains(searchString.toLowerCase()))
        .toList();
    return newData;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      key: _scaffoldKey,
      drawer: const DrawerMenu(),
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 30),
          child: AppNameWidget(),
        ),
        actions: const [UserCartAppbar(), UserPopupMenu()],
      ),

      ///Product Area
      body: SingleChildScrollView(
          child: SafeArea(
              child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              onChanged: (value) {
                setState(() {
                  searchString = value;
                });
              },
              controller: editingController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Cari nama produk, toko produk, kategori produk ...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
                focusedBorder:
                    OutlineInputBorder(borderSide: BorderSide(width: 1.0)),
              ),
            ),
          ),
          FutureBuilder<List<ProductModel>>(
            future: futureProduct,
            builder: (context, data) {
              if (data.hasData) {
                List<ProductModel> result = filterSearch(data);
                return GridView.builder(
                  padding: const EdgeInsets.all(15),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2.5 / 4,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                  ),
                  itemCount: result.length,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (BuildContext context, int i) {
                    return ProductCard(product: result[i]);
                  },
                );
              } else if (data.hasError) {
                return Text("${data.error}");
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.35,
                  ),
                  const CircularProgressIndicator(
                    color: Colors.orange,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Loading Data ...')
                ],
              );
            },
          ),
        ],
      ))),
    );
  }
}
