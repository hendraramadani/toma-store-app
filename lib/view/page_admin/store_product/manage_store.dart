import 'package:cached_network_image/cached_network_image.dart';
import 'package:super_store_e_commerce_flutter/imports.dart';

class ManageStore extends StatefulWidget {
  const ManageStore({Key? key}) : super(key: key);

  @override
  _ManageStoreState createState() => _ManageStoreState();
}

class _ManageStoreState extends State<ManageStore> {
  late bool isLoading = false;
  TextEditingController editingController = TextEditingController();

  List<StoreModel>? items = [];

  List<StoreModel>? responseData = [];
  Future<List<StoreModel>?> getStore() async {
    setState(() {
      isLoading = true;
    });

    responseData = (await StoreApiService().getStore());

    return responseData;
  }

  Future<List<StoreModel>?> updateStore(id, name, phone, address) async {
    List<StoreModel>? responseData =
        (await StoreApiService().updateStore(id, name, phone, address));

    return responseData;
  }

  void refreshPage() {
    setState(() {});
  }

  @override
  void initState() {
    getStore().then((result) {
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
              item.name
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              item.address
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
        actions: const [
          AdminPopMenu(),
        ],
      ),
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
                hintText: "Cari Toko...",
                prefixIcon: Icon(Icons.search),
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
                      Text('Loading Data ...')
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
                                        imageUrl: items![index].image,
                                        height: 106,
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
                                                      text: items![index].name,
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
                                                  text: items![index].address,
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
                                                  editStore(context, size,
                                                      items![index]);
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

  editStore(BuildContext context, Size size, StoreModel data) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    setState(() {
      nameController.text = data.name;
      phoneController.text = data.phone;
      addressController.text = data.address;
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
                    text: 'Ubah Toko',
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
                        hintText: 'Nama',
                        prefixIcon: Icon(Icons.store_mall_directory_outlined),
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
                      controller: addressController,
                      decoration: const InputDecoration(
                        hintText: 'Alamat',
                        prefixIcon: Icon(Icons.maps_home_work_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
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
                        updateStore(data.id, nameController.text,
                                phoneController.text, addressController.text)
                            .then(
                          (result) {
                            QuickAlert.show(
                                context: context,
                                type: QuickAlertType.success,
                                text: 'Perubahan data toko berhasil!',
                                onConfirmBtnTap: () async {
                                  await Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const ManageStore(),
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
