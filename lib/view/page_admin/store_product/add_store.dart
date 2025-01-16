import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:super_store_e_commerce_flutter/imports.dart';
import 'package:flutter/cupertino.dart';

class AdminAddStore extends StatefulWidget {
  const AdminAddStore({Key? key}) : super(key: key);

  @override
  _AddStoreState createState() => _AddStoreState();
}

class _AddStoreState extends State<AdminAddStore> {
  final _formKey = GlobalKey<FormState>();
  late bool isLoading = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();

  late List<StoreModel>? _storeModel = [];
  Future<List<StoreModel>?> _postStoreData() async {
    setState(() {
      isLoading = true;
    });
    _storeModel = (await StoreApiService().addStore(
      nameController.text,
      phoneController.text,
      addressController.text,
      _image,
      latitudeController.text,
      longitudeController.text,
    ));

    return _storeModel;
  }

  File? _image;
  final picker = ImagePicker();

  //Image Picker function to get image from gallery
  Future getImageFromGallery() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

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
        _image = File(
          pickedFile.path,
        );
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
      appBar: AppBar(
          centerTitle: true,
          title: const AppNameWidget(),
          actions: const [AdminPopMenu()]),
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
                    TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        autofillHints: const [AutofillHints.name],
                        validator: ValidationBuilder().minLength(1).build(),
                        decoration: const InputDecoration(
                          hintText: 'Nama Toko',
                          prefixIcon: Icon(Icons.store_mall_directory_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                        )),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      autofillHints: const [AutofillHints.telephoneNumber],
                      validator:
                          ValidationBuilder().phone().minLength(10).build(),
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
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: addressController,
                      keyboardType: TextInputType.streetAddress,
                      validator: ValidationBuilder().minLength(10).build(),
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
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: latitudeController,
                      validator: ValidationBuilder().minLength(8).build(),
                      decoration: const InputDecoration(
                        hintText: 'Latitude',
                        prefixIcon: Icon(Icons.streetview),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: longitudeController,
                      validator: ValidationBuilder().minLength(8).build(),
                      decoration: const InputDecoration(
                        hintText: 'longitude',
                        prefixIcon: Icon(Icons.streetview),
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
                                backgroundColor: Colors.grey.shade300),
                            onPressed: showOptions,
                            icon: const Icon(
                              // color: Colors.blueGrey,
                              Icons.image_outlined,
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
                    const SizedBox(height: 30.0),
                    Center(
                      child: MaterialButton(
                        height: 60,
                        color: Colors.black,
                        minWidth: size.width * 0.8,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // print(emailController.text);

                            if (_image != null) {
                              _postStoreData().then((result) {
                                isLoading = false;
                                if (result!.isNotEmpty) {
                                  setState(() {
                                    QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.success,
                                      text:
                                          'Transaction Completed Successfully!',
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
                                  phoneController.clear();
                                  addressController.clear();
                                  imageController.clear();
                                  latitudeController.clear();
                                  longitudeController.clear();
                                  _image = null;
                                });
                              });
                            } else {
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.error,
                                title: 'Foto belum ditambahkan !',
                              );
                            }
                          }
                          // Navigator.pushAndRemoveUntil(
                          //     context,
                          //     MaterialPageRoute(builder: (_) => const Login()),
                          //     (route) => false);
                        },
                        child: const TextBuilder(
                          text: 'Tambah Toko',
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
