import 'dart:io';

import 'package:super_store_e_commerce_flutter/imports.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:super_store_e_commerce_flutter/model/product.dart';
import 'package:flutter/cupertino.dart';

class AdminAddProduct extends StatefulWidget {
  const AdminAddProduct({Key? key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AdminAddProduct> {
  final _formKey = GlobalKey<FormState>();
  late bool isLoading = false;
  final storeDropdownKey = GlobalKey<DropdownSearchState<StoreModel>>();
  final productCategoryDropdownKey =
      GlobalKey<DropdownSearchState<ProductCategoryModel>>();
  late int dropdownStoreValue;
  late int dropdownProductCategoryValue;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController costController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getPageData().then((result) {
      // print(_stordata![0].name);
    });
    // Future.delayed(const Duration(seconds: 1)).then((value) => getData());
  }

  late List<ProductsModel>? _productModel = [];

  Future<List<ProductsModel>?> _postProductData() async {
    setState(() {
      isLoading = true;
    });
    _productModel = (await ProductApiService().addProduct(
      nameController.text,
      stockController.text,
      descriptionController.text,
      costController.text,
      dropdownProductCategoryValue,
      _image,
      dropdownStoreValue,
    ));

    return _productModel;
  }

  late List<StoreModel>? _storeData = [];
  late List<ProductCategoryModel>? _productCategoryData = [];
  Future _getPageData() async {
    _storeData = (await GetStoreApiService().getStore());
    _productCategoryData =
        (await GetProductCategoryApiService().getProductCategory());
  }

  File? _image;
  final picker = ImagePicker();

  //Image Picker function to get image from gallery
  Future getImageFromGallery() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    print(_image);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  //Image Picker function to get image from camera
  Future getImageFromCamera() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  //Show options to get image from camera or gallery
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
              getImageFromGallery();
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from camera
              getImageFromCamera();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      drawer: const AdminDrawerMenu(),
      appBar:
          AppBar(title: const AppNameWidget(), actions: const [AdminPopMenu()]),
      body: isLoading == true
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Colors.orange,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Loading submit ...')
                ],
              ),
            )
          : Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    DropdownSearch<StoreModel>(
                      validator: (value) {
                        if (value == null) return "Toko Belum Dipilih !";
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          dropdownStoreValue = value!.id;
                        });
                      },
                      itemAsString: (item) => item.name,
                      items: (filter, infiniteScrollProps) => _storeData!,
                      compareFn: (i0, i2) => i0 == i2,
                      popupProps: const PopupProps.menu(
                          cacheItems: true,
                          showSelectedItems: true,
                          showSearchBox: true,
                          searchFieldProps: TextFieldProps(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                              hintText: "Cari Toko...",
                            ),
                          ),
                          fit: FlexFit.loose),
                      decoratorProps: const DropDownDecoratorProps(
                        decoration: InputDecoration(
                          labelText: 'Pilih Toko ',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    DropdownSearch<ProductCategoryModel>(
                      validator: (value) {
                        if (value == null) {
                          return "Kategori Produk Belum Dipilih !";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          dropdownProductCategoryValue = value!.id;
                        });
                      },
                      itemAsString: (item) => item.name,
                      items: (filter, infiniteScrollProps) =>
                          _productCategoryData!,
                      compareFn: (i0, i2) => i0 == i2,
                      popupProps: const PopupProps.menu(
                          cacheItems: true,
                          showSelectedItems: true,
                          showSearchBox: true,
                          searchFieldProps: TextFieldProps(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                              hintText: "Cari Kategori...",
                            ),
                          ),
                          fit: FlexFit.loose),
                      decoratorProps: const DropDownDecoratorProps(
                        decoration: InputDecoration(
                          labelText: 'Pilih Kategori Produk ',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        autofillHints: const [AutofillHints.name],
                        validator: ValidationBuilder().minLength(1).build(),
                        decoration: const InputDecoration(
                          hintText: 'Nama Produk',
                          prefixIcon:
                              Icon(Icons.local_convenience_store_rounded),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                        )),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: stockController,
                      keyboardType: TextInputType.number,
                      validator: ValidationBuilder().minLength(1).build(),
                      decoration: const InputDecoration(
                        hintText: 'Stok',
                        prefixIcon:
                            Icon(Icons.production_quantity_limits_rounded),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: descriptionController,
                      keyboardType: TextInputType.text,
                      validator: ValidationBuilder().minLength(10).build(),
                      decoration: const InputDecoration(
                        hintText: 'Deskripsi',
                        prefixIcon: Icon(Icons.description),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: costController,
                      keyboardType: TextInputType.number,
                      validator: ValidationBuilder().minLength(1).build(),
                      decoration: const InputDecoration(
                        hintText: 'Harga',
                        prefixIcon: Icon(Icons.price_check),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
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
                                backgroundColor: Colors.grey),
                            onPressed: showOptions,
                            icon: const Icon(
                              // color: Colors.blueGrey,
                              Icons.image,
                              size: 30,
                            ),
                          ),
                          // ElevatedButton(
                          //     onPressed: showOptions,
                          //     child: const Icon(Icons.image)),
                          _image == null
                              ? TextButton(
                                  onPressed: showOptions,
                                  child: const Text(
                                    'Pilih Gambar !',
                                    style: TextStyle(color: Colors.black87),
                                  ))
                              : Image.file(_image!),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Center(
                      child: MaterialButton(
                        height: 60,
                        color: Colors.black,
                        minWidth: size.width * 0.8,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            //   // print(emailController.text);
                            _postProductData().then((result) {
                              isLoading = false;
                              if (result!.isNotEmpty) {
                                setState(() {
                                  QuickAlert.show(
                                    context: context,
                                    type: QuickAlertType.success,
                                    text: 'Transaction Completed Successfully!',
                                  );
                                });
                              } else {
                                setState(() {
                                  QuickAlert.show(
                                    context: context,
                                    type: QuickAlertType.error,
                                    title: 'Oops...',
                                    text: 'Sorry, something went wrong',
                                  );
                                });
                              }

                              setState(() {
                                nameController.clear();
                                stockController.clear();
                                descriptionController.clear();
                                costController.clear();
                                _image = null;
                              });
                            });
                          }
                          // Navigator.pushAndRemoveUntil(
                          //     context,
                          //     MaterialPageRoute(builder: (_) => const Login()),
                          //     (route) => false);
                        },
                        child: const TextBuilder(
                          text: 'Tambah Product',
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
