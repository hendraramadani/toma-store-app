import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_store_e_commerce_flutter/imports.dart';
import 'package:intl/intl.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  bool isLoading = false;
  List<InvoiceModel>? _orderModel = [];

  Future<int?> getId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getInt('id');

    return userId;
  }

  Future<List<InvoiceModel>?> storeOrder(id, data) async {
    String json = cartModelToJson(data);
    _orderModel = (await OrderApiService().storeOrder(id, json));

    return _orderModel;
  }

  late String userAddress;
  Future initPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userAddress = prefs.getString('address').toString();
    // print(userAddress);
    return;
  }

  @override
  void initState() {
    initPrefs().then((result) {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.simpleCurrency(locale: 'id_ID');
    var cart = Provider.of<CartProvider>(context);
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const UserHome()));
            }),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const AppNameWidget(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Container(
              height: 25,
              width: 25,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.orange),
              child: TextBuilder(
                text: cart.itemCount.toString(),
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(15),
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemCount: cart.items.length,
          itemBuilder: (BuildContext context, int i) {
            return CartCard(cart: cart.items[i]);
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 10.0);
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MaterialButton(
          height: 60,
          color: Colors.black,
          minWidth: size.width,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          onPressed: () {
            //async function order (ID,item)

            final ScaffoldMessengerState buyNow = ScaffoldMessenger.of(context);
            if (cart.items.isEmpty == true) {
              buyNow.showSnackBar(
                SnackBar(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                  content: const TextBuilder(
                      fontWeight: FontWeight.w300,
                      text: 'Transaksi Gagal, Masukkan Produk ke Keranjang !'),
                ),
              );
            } else {
              if (userAddress == "") {
                buyNow.showSnackBar(
                  SnackBar(
                    action: SnackBarAction(
                        label: 'Ubah Alamat',
                        textColor: Colors.black,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const UserAddress()));
                        }),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                    content: const TextBuilder(
                        fontWeight: FontWeight.w300,
                        text: 'Transaksi Gagal, Alamat tujuan perlu diisi !'),
                  ),
                );
              } else {
                getId().then((result) => {
                      buyNow.showSnackBar(
                        SnackBar(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                          behavior: SnackBarBehavior.floating,
                          content: const TextBuilder(
                              fontWeight: FontWeight.w300,
                              text:
                                  'Transaksi Berhasil, Tunggu kurir menjemput barang anda !'),
                        ),
                      ),
                      storeOrder(result, cart.items).then((result) => {
                            cart.clearList(),
                            setState(() {}),
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => Invoice(_orderModel)))
                          }),
                    });
              }
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextBuilder(
                  text: formatCurrency.format(cart.totalPrice()).toString(),
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 20),
              const SizedBox(width: 10.0),
              const TextBuilder(
                text: 'Bayar Sekarang',
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
