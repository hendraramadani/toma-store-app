import 'package:intl/intl.dart';
import 'package:rounded_background_text/rounded_background_text.dart';
import 'package:super_store_e_commerce_flutter/imports.dart';
import 'package:super_store_e_commerce_flutter/model/courier_order.dart';

class TakenOrder extends StatefulWidget {
  const TakenOrder({Key? key}) : super(key: key);

  @override
  _TakenOrderState createState() => _TakenOrderState();
}

class _TakenOrderState extends State<TakenOrder> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final formatCurrency = NumberFormat.simpleCurrency(locale: 'id_ID');
  final TextEditingController storeName = TextEditingController();
  String selectedValue = '1';
  bool isLoadingData = false;
  String store_name = '';

  late List<CourierOrderModel>? userOrder = [];
  Future<List<CourierOrderModel>?> _useOrder() async {
    isLoadingData = true;
    userOrder = (await CourierApiService().getListTakenCourierOrder());
    isLoadingData = false;

    setState(() {});
    return userOrder;
  }

  Future<void> deliverOrder(orderId) async {
    (await CourierApiService().deliverOrderCourier(orderId));
    return;
  }

  Future<void> cancelOrder(orderId) async {
    (await CourierApiService().cancelOrderCourier(orderId));
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
        title: const Padding(
          padding: EdgeInsets.only(left: 30),
          child: AppNameWidget(),
        ),
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
              ? const Center(child: Text('Belum ada pesanan diambil'))
              : ListView.builder(
                  itemCount: userOrder!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(2),
                      child: Card(
                        child: ExpansionTile(
                          title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Invoice #${userOrder![index].order.id}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                Text(
                                    DateFormat('dd MMM yyyy HH:mm').format(
                                        userOrder![index].order.createdAt),
                                    style: const TextStyle(fontSize: 12)),
                                RoundedBackgroundText(
                                  userOrder![index].order.status,
                                  style: const TextStyle(fontSize: 11),
                                  backgroundColor: Colors.orange,
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
                                  Text(
                                      'Customer : ${userOrder![index].order.name}'),
                                  Text(
                                      'Alamat : ${userOrder![index].order.address}'),
                                  const Divider(),
                                  Text(
                                      "Total Harga : ${formatCurrency.format((userOrder![index].order.totalCost)).toString()}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                if (userOrder![index].order.statusOrderId != 2)
                                  TextButton(
                                      style: TextButton.styleFrom(
                                          side: const BorderSide(
                                              width: 1.5, color: Colors.red)),
                                      onPressed: () {
                                        QuickAlert.show(
                                          context: context,
                                          confirmBtnText: 'Konfirmasi',
                                          confirmBtnColor: Colors.orange,
                                          headerBackgroundColor: Colors.orange,
                                          type: QuickAlertType.info,
                                          title: 'Peringatan',
                                          text:
                                              'Batalkan Pengantaran Pesanan ?',
                                          barrierDismissible: true,
                                          showCancelBtn: true,
                                          onConfirmBtnTap: () async {
                                            cancelOrder(
                                                    userOrder![index].order.id)
                                                .then(
                                                    (result) => {_useOrder()});
                                            Navigator.pop(context);
                                            return;
                                          },
                                        );

                                        setState(() {});
                                      },
                                      child: const Text(
                                        'Batalkan Antar',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 12),
                                      )),
                                const SizedBox(
                                  width: 10,
                                ),
                                TextButton(
                                    style: TextButton.styleFrom(
                                        side: const BorderSide(
                                            width: 1.5, color: Colors.orange)),
                                    onPressed: () {
                                      openOrderDetail(
                                          context, size, userOrder![index]);
                                    },
                                    child: const Text(
                                      'Detail',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    )),
                                const SizedBox(
                                  width: 10,
                                ),
                                if (userOrder![index].order.statusOrderId != 2)
                                  TextButton(
                                    style: TextButton.styleFrom(
                                        side: const BorderSide(
                                            width: 1.5, color: Colors.green)),
                                    onPressed: () {
                                      deliverOrder(userOrder![index].order.id)
                                          .then((result) => {
                                                QuickAlert.show(
                                                  context: context,
                                                  type: QuickAlertType.success,
                                                  text:
                                                      'Pengambilan Pesanan Sukses !',
                                                ),
                                                _useOrder()
                                              });
                                      setState(() {});
                                    },
                                    child: const Text(
                                      'Antar Pesanan',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    ),
                                  ),
                                const SizedBox(
                                  width: 15,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }

  openOrderDetail(BuildContext context, Size size, CourierOrderModel data) {
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
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (store_name == data.detail[index].storeName) ...{
                            const Padding(
                                padding: EdgeInsets.all(3.0),
                                child: Text(
                                  "Store Name",
                                  style: TextStyle(fontSize: 15),
                                )),
                          },
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
                          )
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(),
                      Text(
                        "Total : ${formatCurrency.format(data.order.totalCost).toString()}",
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
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
