import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:rounded_background_text/rounded_background_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_store_e_commerce_flutter/imports.dart';
import 'package:super_store_e_commerce_flutter/model/courier_order.dart';

class DoneOrder extends StatefulWidget {
  const DoneOrder({Key? key}) : super(key: key);

  @override
  _DoneOrderState createState() => _DoneOrderState();
}

class _DoneOrderState extends State<DoneOrder> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final formatCurrency = NumberFormat.simpleCurrency(locale: 'id_ID');
  final TextEditingController storeName = TextEditingController();
  String selectedValue = '1';
  bool isLoadingData = false;

  late List<CourierOrderModel>? userOrder = [];
  Future<List<CourierOrderModel>?> _useOrder() async {
    isLoadingData = true;
    userOrder = (await CourierApiService().getListDoneCourierOrder());
    isLoadingData = false;

    setState(() {});
    return userOrder;
  }

  Future<void> takeOrder(orderId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var courierId = prefs.getInt('courier_id');
    (await CourierApiService().assignOrderCourier(orderId, courierId));
    return;
  }

  @override
  void initState() {
    _useOrder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      key: _scaffoldKey,
      drawer: const CourierDrawerMenu(),
      appBar: AppBar(
        centerTitle: true,
        title: AppNameWidget(),
        actions: const [CourierPopupMenu()],
      ),
      body: isLoadingData == true
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Colors.orange,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text('Loading Data')
                ],
              ),
            )
          : userOrder!.isEmpty
              ? const Center(child: Text('Tidak ada pesanan selesai'))
              : ListView.builder(
                  itemCount: userOrder!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.all(2),
                        child: Card(
                          child: ExpansionTile(
                            title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Invoice #${userOrder![index].order.id}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      DateFormat('dd MMM yyyy HH:mm').format(
                                          userOrder![index]
                                              .order
                                              .createdAt
                                              .toLocal()),
                                      style: const TextStyle(fontSize: 12)),
                                  RoundedBackgroundText(
                                    userOrder![index].order.status,
                                    style: const TextStyle(fontSize: 11),
                                    backgroundColor: Colors.green,
                                  ),
                                ]),
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 5, left: 15, right: 25),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Divider(),
                                      Text(
                                          'Pelanggan : ${userOrder![index].order.name}'),
                                      Text(
                                          'Alamat : ${userOrder![index].order.address}'),
                                      const Divider(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              "Total Harga : ${formatCurrency.format((userOrder![index].order.totalCost)).toString()}",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          Row(
                                            children: [
                                              TextButton(
                                                  style: TextButton.styleFrom(
                                                      side: const BorderSide(
                                                          width: 1.5,
                                                          color:
                                                              Colors.orange)),
                                                  onPressed: () {
                                                    openOrderDetail(
                                                        context,
                                                        size,
                                                        userOrder![index]);
                                                  },
                                                  child: const Text(
                                                    'Detail',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12),
                                                  )),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              if (userOrder![index]
                                                      .order
                                                      .image !=
                                                  null)
                                                TextButton(
                                                    style: TextButton.styleFrom(
                                                        side: const BorderSide(
                                                            width: 1.5,
                                                            color:
                                                                Colors.green)),
                                                    onPressed: () {
                                                      openImageOrder(
                                                          context,
                                                          size,
                                                          userOrder![index]
                                                              .order
                                                              .image);
                                                    },
                                                    child: const Text(
                                                      'Lihat Foto',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12),
                                                    )),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  )),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ));
                  },
                ),
    );
  }

  openImageOrder(BuildContext context, Size size, String imageUrl) {
    showDialog(
      context: context,
      useSafeArea: true,
      barrierDismissible: true,
      builder: (context) {
        return Center(
          child: AlertDialog(
            actionsPadding: EdgeInsets.zero,
            buttonPadding: EdgeInsets.zero,
            contentPadding: const EdgeInsets.all(25),
            iconPadding: EdgeInsets.zero,
            elevation: 0,
            title: SizedBox(
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        size: 20,
                        color: Colors.black,
                      ))
                ],
              ),
            ),
            content: SizedBox(
              width: double.maxFinite,
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(
                        color: Colors.orange, value: downloadProgress.progress),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
        );
      },
    );
  }

  openOrderDetail(BuildContext context, Size size, CourierOrderModel data) {
    String store_name = '';
    bool storeChange = true;
    showDialog(
      context: context,
      useSafeArea: true,
      barrierDismissible: true,
      builder: (context) {
        return Center(
          child: AlertDialog(
            actionsPadding: EdgeInsets.zero,
            buttonPadding: EdgeInsets.zero,
            contentPadding: const EdgeInsets.all(25),
            iconPadding: EdgeInsets.zero,
            elevation: 0,
            title: SizedBox(
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextBuilder(
                    text: "Invoice #${data.order.id}",
                    fontWeight: FontWeight.w300,
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        size: 20,
                        color: Colors.black,
                      ))
                ],
              ),
            ),
            content: SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.detail.length,
                    itemBuilder: (context, index) {
                      if (data.detail[index].storeName != store_name) {
                        store_name = data.detail[index].storeName;
                        storeChange = true;
                      } else if (data.detail[index].storeName == store_name) {
                        storeChange = false;
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (storeChange == true) const Divider(),
                          if (storeChange == true)
                            Text(
                              'Toko : ${store_name}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text(
                                  "${index + 1}. ${data.detail[index].productName} (${data.detail[index].amount} pcs) ",
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text(
                                  formatCurrency
                                      .format(data.detail[index].cost)
                                      .toString(),
                                  style: const TextStyle(fontSize: 15),
                                ),
                              )
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                  Column(
                    children: [
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Total : ${formatCurrency.format(data.order.totalCost).toString()}",
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
