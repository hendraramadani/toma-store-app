import 'package:intl/intl.dart';
import 'package:rounded_background_text/rounded_background_text.dart';
import 'package:super_store_e_commerce_flutter/imports.dart';
import 'package:super_store_e_commerce_flutter/model/admin_order.dart';

class AdminOrder extends StatefulWidget {
  const AdminOrder({Key? key}) : super(key: key);

  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<AdminOrder> {
  final formatCurrency = NumberFormat.simpleCurrency(locale: 'id_ID');
  bool isLoading = false;
  TextEditingController editingController = TextEditingController();
  String store_name = '';

  List<AdminOrderModel>? items = [];

  List<AdminOrderModel>? responseData = [];
  Future<List<AdminOrderModel>?> getAdminOrderList() async {
    isLoading = true;
    responseData = (await OrderApiService().getAdminOrder());

    return responseData;
  }

  @override
  void initState() {
    getAdminOrderList().then((result) {
      setState(() {
        isLoading = false;
        items = responseData;
      });
    });

    super.initState();
  }

  void filterSearchResults(String query) {
    setState(() {
      items = responseData
          ?.where((item) =>
              item.order.id
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              item.order.totalCost
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              item.order.status.toLowerCase().contains(query.toLowerCase()) ||
              item.order.address.toLowerCase().contains(query.toLowerCase()) ||
              item.order.name.toLowerCase().contains(query.toLowerCase()) ||
              item.order.courierName
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      drawer: const AdminDrawerMenu(),
      appBar: AppBar(
        title: const AppNameWidget(),
        actions: const [AdminPopMenu()],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                filterSearchResults(value);
              },
              controller: editingController,
              decoration: const InputDecoration(
                  hintText: "Cari...",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),
            ),
          ),
          isLoading == true
              ? const Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      CircularProgressIndicator(
                        color: Colors.orange,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Loading Data ...')
                    ],
                  ),
                )
              : Expanded(
                  child: responseData!.isEmpty
                      ? const Center(
                          child: Text('Belum pernah melakukan pesanan'))
                      : ListView.builder(
                          itemCount: items!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                                padding: const EdgeInsets.all(2),
                                child: Card(
                                  child: ExpansionTile(
                                    title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              'Invoice #${items![index].order.id}',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          Text(
                                              DateFormat('dd MMM yyyy HH:mm')
                                                  .format(items![index]
                                                      .order
                                                      .createdAt
                                                      .toLocal()),
                                              style: const TextStyle(
                                                  fontSize: 12)),
                                          if (items![index]
                                                  .order
                                                  .statusOrderId ==
                                              1)
                                            RoundedBackgroundText(
                                              items![index].order.status,
                                              style:
                                                  const TextStyle(fontSize: 11),
                                              backgroundColor: Colors.orange,
                                            ),
                                          if (items![index]
                                                  .order
                                                  .statusOrderId ==
                                              2)
                                            RoundedBackgroundText(
                                              items![index].order.status,
                                              style:
                                                  const TextStyle(fontSize: 11),
                                              backgroundColor: Colors.orange,
                                            ),
                                          if (items![index]
                                                  .order
                                                  .statusOrderId ==
                                              3)
                                            RoundedBackgroundText(
                                              items![index].order.status,
                                              style:
                                                  const TextStyle(fontSize: 11),
                                              backgroundColor: Colors.orange,
                                            ),
                                          if (items![index]
                                                  .order
                                                  .statusOrderId ==
                                              4)
                                            RoundedBackgroundText(
                                              items![index].order.status,
                                              style:
                                                  const TextStyle(fontSize: 11),
                                              backgroundColor: Colors.green,
                                            ),
                                          if (items![index]
                                                  .order
                                                  .statusOrderId ==
                                              5)
                                            RoundedBackgroundText(
                                              items![index].order.status,
                                              style:
                                                  const TextStyle(fontSize: 11),
                                              backgroundColor: Colors.red,
                                            ),
                                        ]),
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5,
                                            bottom: 5,
                                            left: 15,
                                            right: 25),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Divider(),
                                            Text(
                                                'Pelanggan : ${items![index].order.name} '),
                                            Text(
                                                'Alamat : ${items![index].order.address} '),
                                            const Divider(),
                                            if (items![index]
                                                    .order
                                                    .courierName !=
                                                null) ...{
                                              Text(
                                                  'Kurir : ${items![index].order.courierName}'),
                                              const Divider(),
                                            },
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    "Total Harga : ${formatCurrency.format((items![index].order.totalCost)).toString()}",
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    TextButton(
                                                        style: TextButton.styleFrom(
                                                            side: const BorderSide(
                                                                width: 1.5,
                                                                color: Colors
                                                                    .orange)),
                                                        onPressed: () {
                                                          openOrderDetail(
                                                              context,
                                                              size,
                                                              items![index]);
                                                        },
                                                        child: const Text(
                                                          'Detail Pesanan',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 12),
                                                        )),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
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
                ),
        ],
      ),
    );
  }

  openOrderDetail(BuildContext context, Size size, AdminOrderModel data) {
    showDialog(
      context: context,
      useSafeArea: true,
      barrierDismissible: true,
      builder: (context) {
        return Center(
          child: AlertDialog(
            actionsPadding: EdgeInsets.zero,
            buttonPadding: EdgeInsets.zero,
            contentPadding: const EdgeInsets.all(15),
            iconPadding: EdgeInsets.zero,
            elevation: 0,
            title: SizedBox(
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextBuilder(
                    text: "Invoice #${data.order.id}",
                    fontSize: 17,
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
                      // store_name = data.detail[index].storeName;

                      if (data.detail[index].storeName != store_name) {
                        store_name = data.detail[index].storeName;
                        print(store_name);
                      } else {
                        store_name = '';
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (store_name != '') Divider(),
                          if (store_name != '')
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
