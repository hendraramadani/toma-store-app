import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

  Future<List<StoreModel>?> updateStore(id, name, phone, address, image) async {
    List<StoreModel>? responseData =
        (await StoreApiService().updateStore(id, name, phone, address, image));

    return responseData;
  }

  Future<void> deleteStore(String storeId) async {
    (await StoreApiService().deleteStore(storeId));
    return;
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
        centerTitle: true,
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
                                        // cacheKey: items![index].image +
                                        //     DateTime.now().day.toString(),
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
                                                  QuickAlert.show(
                                                    context: context,
                                                    type: QuickAlertType.error,
                                                    title: 'Konfirmasi',
                                                    text: 'Hapus Data Toko ?',
                                                    confirmBtnText:
                                                        'Konfirmasi',
                                                    confirmBtnColor: Colors.red,
                                                    cancelBtnText: 'Batalkan',
                                                    onConfirmBtnTap: () {
                                                      deleteStore(items![index]
                                                              .id
                                                              .toString())
                                                          .then((result) async {
                                                        setState(() {
                                                          items!
                                                              .removeAt(index);
                                                        });
                                                        Navigator.pop(context);
                                                      });
                                                    },
                                                    showCancelBtn: true,
                                                  );
                                                },
                                                style: TextButton.styleFrom(
                                                  side: const BorderSide(
                                                      width: 1.5,
                                                      color: Colors.red),
                                                ),
                                                child: const Text(
                                                  'Hapus',
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  editStore(context, size,
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

  editStore(BuildContext context, Size size, StoreModel data, int index) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController addressController = TextEditingController();

    StateSetter _setState;
    File? _image;
    final picker = ImagePicker();

    setState(() {
      nameController.text = data.name;
      phoneController.text = data.phone;
      addressController.text = data.address;
    });

    void updateState(String newImagePath) {
      setState(() {
        items![index].name = nameController.text;
        items![index].phone = phoneController.text;
        items![index].address = addressController.text;

        if (_image != null) items![index].image = newImagePath;
      });
    }

    showDialog(
      context: context,
      useSafeArea: true,
      barrierDismissible: true,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          _setState = setState;

          Future getImageFromGallery() async {
            final pickedFile = await picker.pickImage(
                source: ImageSource.gallery, imageQuality: 50);

            _setState(() {
              if (pickedFile != null) {
                _image = File(pickedFile.path);
              }
            });
          }

          //Image Picker function to get image from camera
          Future getImageFromCamera() async {
            final pickedFile = await picker.pickImage(
                source: ImageSource.camera, imageQuality: 50);

            _setState(() {
              if (pickedFile != null) {
                _image = File(pickedFile.path);
              }
            });
          }

          Future showOptions() async {
            showCupertinoModalPopup(
              context: context,
              builder: (context) => CupertinoActionSheet(
                actions: [
                  CupertinoActionSheetAction(
                    child: const Text('Photo Gallery'),
                    onPressed: () {
                      // close the options modal
                      Navigator.of(context).pop();
                      // get image from gallery
                      getImageFromGallery().then((result) {});
                    },
                  ),
                  CupertinoActionSheetAction(
                    child: const Text('Camera'),
                    onPressed: () {
                      // close the options modal
                      Navigator.of(context).pop();
                      // get image from camera
                      getImageFromCamera().then((result) {});
                    },
                  ),
                ],
              ),
            );
          }

          return AlertDialog(
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
                        hintText: 'No. Whatsapp',
                        prefixIcon: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [FaIcon(FontAwesomeIcons.whatsapp)],
                        ),
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
                    const SizedBox(height: 10.0),
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all()),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            style: IconButton.styleFrom(
                                backgroundColor: Colors.grey.shade300),
                            onPressed: showOptions,
                            icon: const Icon(
                              // color: Colors.blueGrey,
                              Icons.image_outlined,
                              size: 30,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          // ElevatedButton(
                          //     onPressed: showOptions,
                          //     child: const Icon(Icons.image)),
                          _image == null
                              ? TextButton(
                                  onPressed: () {
                                    showOptions();
                                  },
                                  child: const Text(
                                    'Pilih Gambar !',
                                    style: TextStyle(color: Colors.black87),
                                  ))
                              : Image.file(_image!),
                        ],
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
                        updateStore(
                                data.id,
                                nameController.text,
                                phoneController.text,
                                addressController.text,
                                _image)
                            .then(
                          (result) {
                            QuickAlert.show(
                                context: context,
                                type: QuickAlertType.success,
                                text: 'Perubahan data toko berhasil!',
                                onConfirmBtnTap: () async {
                                  updateState(result![0].image);
                                  Navigator.pop(context);
                                  Navigator.pop(context);

                                  // await Navigator.pushReplacement(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (_) => const ManageStore(),
                                  //   ),
                                  // );
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
          );
        });
      },
    );
  }
}
