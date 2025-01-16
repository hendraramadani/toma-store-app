import 'package:cached_network_image/cached_network_image.dart';
import 'package:super_store_e_commerce_flutter/imports.dart';
import 'package:super_store_e_commerce_flutter/model/user_order.dart';
import 'package:intl/intl.dart';
import 'package:rounded_background_text/rounded_background_text.dart';
import 'package:super_store_e_commerce_flutter/view/page_user/utils/whatsapp_launcher.dart';

class UserOrder extends StatefulWidget {
  const UserOrder({Key? key}) : super(key: key);

  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<UserOrder> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final formatCurrency = NumberFormat.simpleCurrency(locale: 'id_ID');
  String selectedValue = '1';
  bool isLoadingData = false;

  late List<UserOrderModel>? userOrder = [];
  Future<List<UserOrderModel>?> _useOrder() async {
    isLoadingData = true;
    userOrder = (await OrderApiService().getUserOrder());
    isLoadingData = false;

    setState(() {});

    return userOrder;
  }

  Future<void> doneOrder(orderId) async {
    (await OrderApiService().doneOrderUser(orderId));
    return;
  }

  Future<void> cancelOrder(orderId) async {
    (await OrderApiService().cancelOrderUser(orderId));
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
      drawer: const DrawerMenu(),
      appBar: AppBar(
        title: AppNameWidget(),
        centerTitle: true,
        actions: const [UserCartAppbar(), UserPopupMenu()],
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
              ? const Center(child: Text('Belum pernah melakukan pesanan'))
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
                                      style: const TextStyle(fontSize: 11)),
                                  if (userOrder![index].order.statusOrderId ==
                                      1)
                                    RoundedBackgroundText(
                                      userOrder![index].order.status,
                                      style: const TextStyle(fontSize: 10),
                                      backgroundColor: Colors.orange,
                                    ),
                                  if (userOrder![index].order.statusOrderId ==
                                      2)
                                    RoundedBackgroundText(
                                      userOrder![index].order.status,
                                      style: const TextStyle(fontSize: 10),
                                      backgroundColor: Colors.orange,
                                    ),
                                  if (userOrder![index].order.statusOrderId ==
                                      3)
                                    RoundedBackgroundText(
                                      userOrder![index].order.status,
                                      style: const TextStyle(fontSize: 10),
                                      backgroundColor: Colors.orange,
                                    ),
                                  if (userOrder![index].order.statusOrderId ==
                                      4)
                                    RoundedBackgroundText(
                                      userOrder![index].order.status,
                                      style: const TextStyle(fontSize: 10),
                                      backgroundColor: Colors.green,
                                    ),
                                  if (userOrder![index].order.statusOrderId ==
                                      5)
                                    RoundedBackgroundText(
                                      userOrder![index].order.status,
                                      style: const TextStyle(fontSize: 10),
                                      backgroundColor: Colors.red,
                                    ),
                                ]),
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 5, bottom: 5, left: 15, right: 25),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Divider(),
                                    if (userOrder![index].order.courierName !=
                                        null)
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              'Kurir : ${userOrder![index].order.courierName}'),
                                          const Divider(),
                                        ],
                                      ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            "Total Harga : ${formatCurrency.format((userOrder![index].order.totalCost)).toString()}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            if (userOrder![index]
                                                    .order
                                                    .statusOrderId ==
                                                3)
                                              TextButton(
                                                  style: TextButton.styleFrom(
                                                      side: const BorderSide(
                                                          width: 1.5,
                                                          color: Colors.red)),
                                                  onPressed: () {
                                                    QuickAlert.show(
                                                      context: context,
                                                      confirmBtnText:
                                                          'Konfirmasi',
                                                      confirmBtnColor:
                                                          Colors.orange,
                                                      headerBackgroundColor:
                                                          Colors.orange,
                                                      type: QuickAlertType.info,
                                                      title: 'Peringatan',
                                                      text:
                                                          'Batalkan Pesanan ?',
                                                      barrierDismissible: true,
                                                      showCancelBtn: true,
                                                      onConfirmBtnTap:
                                                          () async {
                                                        cancelOrder(userOrder![
                                                                    index]
                                                                .order
                                                                .id)
                                                            .then((result) =>
                                                                {_useOrder()});
                                                        Navigator.pop(context);
                                                        return;
                                                      },
                                                    );

                                                    setState(() {});
                                                  },
                                                  child: const Text(
                                                    'Batalkan Pesanan',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12),
                                                  )),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            if (userOrder![index]
                                                        .order
                                                        .statusOrderId ==
                                                    1 ||
                                                userOrder![index]
                                                        .order
                                                        .statusOrderId ==
                                                    2)
                                              TextButton(
                                                  style: TextButton.styleFrom(
                                                      side: const BorderSide(
                                                          width: 1.5,
                                                          color: Colors.green)),
                                                  onPressed: () {
                                                    whatsapp(userOrder![index]
                                                        .order
                                                        .courierPhone);
                                                  },
                                                  child: const Text(
                                                    'Whatsapp Kurir',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12),
                                                  )),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            TextButton(
                                                style: TextButton.styleFrom(
                                                    side: const BorderSide(
                                                        width: 1.5,
                                                        color: Colors.orange)),
                                                onPressed: () {
                                                  openOrderDetail(context, size,
                                                      userOrder![index]);
                                                },
                                                child: const Text(
                                                  'Detail',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12),
                                                )),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            if (userOrder![index]
                                                        .order
                                                        .statusOrderId ==
                                                    2 &&
                                                userOrder![index].order.image !=
                                                    null)
                                              TextButton(
                                                  style: TextButton.styleFrom(
                                                      side: const BorderSide(
                                                          width: 1.5,
                                                          color: Colors.green)),
                                                  onPressed: () {
                                                    doneOrder(userOrder![index]
                                                            .order
                                                            .id)
                                                        .then((result) => {
                                                              QuickAlert.show(
                                                                context:
                                                                    context,
                                                                type:
                                                                    QuickAlertType
                                                                        .success,
                                                                text:
                                                                    'Pesanan Diselesaikan !',
                                                              ),
                                                              _useOrder()
                                                            });
                                                    setState(() {});
                                                  },
                                                  child: const Text(
                                                    'Selesaikan Pesanan',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12),
                                                  )),
                                            if (userOrder![index]
                                                        .order
                                                        .statusOrderId ==
                                                    4 &&
                                                userOrder![index].order.image !=
                                                    null)
                                              TextButton(
                                                  style: TextButton.styleFrom(
                                                      side: const BorderSide(
                                                          width: 1.5,
                                                          color: Colors.green)),
                                                  onPressed: () {
                                                    openImageOrder(
                                                        context,
                                                        size,
                                                        userOrder![index]
                                                            .order
                                                            .image);
                                                  },
                                                  child: const Text(
                                                    'Foto Pengantaran',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12),
                                                  )),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
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

  openOrderDetail(BuildContext context, Size size, UserOrderModel data) {
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
            contentPadding: const EdgeInsets.all(20),
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
                          if (storeChange == true) Divider(),
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
