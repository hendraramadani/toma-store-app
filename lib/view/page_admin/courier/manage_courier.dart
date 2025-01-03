import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:super_store_e_commerce_flutter/imports.dart';
import 'package:super_store_e_commerce_flutter/model/admin_courier.dart';
import 'package:super_store_e_commerce_flutter/model/courier_status_active.dart';

class AdminManageCourier extends StatefulWidget {
  const AdminManageCourier({Key? key}) : super(key: key);

  @override
  _ManageCourierState createState() => _ManageCourierState();
}

class _ManageCourierState extends State<AdminManageCourier> {
  late bool isLoading = false;
  TextEditingController editingController = TextEditingController();

  List<AdminCourierModel>? items = [];
  late List<AdminCourierModel>? responseData = [];
  Future<List<AdminCourierModel>?> getCourierData() async {
    setState(() {
      isLoading = true;
    });
    responseData = (await CourierApiService().getAdminCourier());
    return responseData;
  }

  late List<CourierStatusActiveModel>? courierStatusActiveData = [];
  Future getDropdownData() async {
    courierStatusActiveData =
        (await CourierApiService().getCourierStatusActive());
  }

  Future<List<AdminCourierModel>?> updateCourier(
    courierId,
    userId,
    statusAvailableId,
    courierName,
    courierPhone,
    courierEmail,
  ) async {
    List<AdminCourierModel>? responseData =
        (await CourierApiService().updateAdminCourier(
      courierId,
      userId,
      statusAvailableId,
      courierName,
      courierPhone,
      courierEmail,
    ));

    return responseData;
  }

  @override
  void initState() {
    getCourierData().then((result) {
      getDropdownData().then((result) {
        setState(() {
          isLoading = false;
          items = responseData;
        });
      });
    });

    super.initState();
  }

  void filterSearchResults(String query) {
    setState(
      () {
        items = responseData
            ?.where((item) =>
                item.courierName
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                item.courierEmail
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase()))
            .toList();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      drawer: const AdminDrawerMenu(),
      appBar:
          AppBar(title: const AppNameWidget(), actions: const [AdminPopMenu()]),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                filterSearchResults(value);
              },
              controller: editingController,
              decoration: const InputDecoration(
                hintText: "Cari Kurir ...",
                prefixIcon: Icon(Icons.person_search_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                ),
              ),
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
                      Text('Loading Data Kurir ...')
                    ],
                  ),
                )
              : Expanded(
                  child: responseData!.isEmpty
                      ? const Center(
                          child: Text('Belum ada toko terdaftar.'),
                        )
                      : ListView.separated(
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(height: 5);
                          },
                          cacheExtent: 9999,
                          padding: const EdgeInsets.all(10),
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: items!.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 5,
                              child: Container(
                                // padding: const EdgeInsets.all(2),

                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.orange, width: 1.5),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(7),
                                        topLeft: Radius.circular(7),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            'https://dummyjson.com/image/150', //dummy images
                                        height: 125,
                                        width: 100,
                                        fit: BoxFit.cover,
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) =>
                                                Center(
                                          child: SizedBox(
                                            width: 30,
                                            height: 30,
                                            child: CircularProgressIndicator(
                                                color: Colors.orange,
                                                value:
                                                    downloadProgress.progress),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                    const SizedBox(width: 10.0),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: TextBuilder(
                                                      text: items![index]
                                                          .courierName,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 16,
                                                      maxLines: 3,
                                                      textOverflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Divider(
                                                endIndent: 10,
                                              )
                                            ],
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: TextBuilder(
                                                  text: items![index]
                                                      .courierPhone,
                                                  color: Colors.black,
                                                  maxLines: 3,
                                                  textOverflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: TextBuilder(
                                                  text: items![index]
                                                      .courierEmail,
                                                  color: Colors.black,
                                                  maxLines: 3,
                                                  textOverflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  editCourier(context, size,
                                                      items![index], index);
                                                },
                                                style: TextButton.styleFrom(
                                                  side: const BorderSide(
                                                      width: 1.5,
                                                      color: Colors.orange),
                                                ),
                                                child: const Text(
                                                  'Edit',
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                )
        ],
      ),
    );
  }

  editCourier(
      BuildContext context, Size size, AdminCourierModel data, int index) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    // final TextEditingController costController = TextEditingController();

    // final storeDropdownKey = GlobalKey<DropdownSearchState<StoreModel>>();
    // final productCategoryDropdownKey =
    //     GlobalKey<DropdownSearchState<ProductCategoryModel>>();
    var dropdownStatusValue = data.courierStatusActiveId;
    setState(() {
      nameController.text = data.courierName;
      phoneController.text = data.courierPhone.toString();
      emailController.text = data.courierEmail;
    });
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
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextBuilder(
                    text: 'Ubah Kurir',
                    fontSize: 17,
                    fontWeight: FontWeight.w300,
                  ),
                ],
              ),
            ),
            content: SingleChildScrollView(
              child: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        hintText: 'Nama Kurir',
                        prefixIcon: Icon(Icons.person_4_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'No. HP',
                        prefixIcon: Icon(Icons.phone_android),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    DropdownSearch<CourierStatusActiveModel>(
                      validator: (value) {
                        if (value == null) return "Toko Belum Dipilih !";
                        return null;
                      },
                      selectedItem: courierStatusActiveData![
                          data.courierStatusActiveId - 1],
                      onChanged: (value) {
                        setState(() {
                          dropdownStatusValue = value!.id;
                        });
                      },
                      itemAsString: (item) => item.status,
                      items: (filter, infiniteScrollProps) =>
                          courierStatusActiveData!,
                      compareFn: (i0, i2) => i0 == i2,
                      popupProps: const PopupProps.menu(
                          showSelectedItems: true,
                          // showSearchBox: true,
                          cacheItems: true,
                          constraints: BoxConstraints(maxHeight: 200),
                          searchFieldProps: TextFieldProps(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                              hintText: "Cari Status Aktif...",
                            ),
                          ),
                          fit: FlexFit.loose),
                      decoratorProps: const DropDownDecoratorProps(
                        decoration: InputDecoration(
                          labelText: 'Pilih Status Aktif',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: MaterialButton(
                      onPressed: () async {
                        updateCourier(
                                data.id,
                                data.userId,
                                dropdownStatusValue,
                                nameController.text,
                                phoneController.text,
                                emailController.text)
                            .then(
                          (result) {
                            QuickAlert.show(
                                context: context,
                                type: QuickAlertType.success,
                                text: 'Perubahan data kurir berhasil!',
                                onConfirmBtnTap: () async {
                                  await Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          const AdminManageCourier(),
                                    ),
                                  );
                                });
                          },
                        );
                      },
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const TextBuilder(
                        text: 'Simpan',
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
