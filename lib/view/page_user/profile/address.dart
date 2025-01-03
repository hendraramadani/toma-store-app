import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_store_e_commerce_flutter/imports.dart';

class UserAddress extends StatefulWidget {
  const UserAddress({Key? key}) : super(key: key);

  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<UserAddress> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String selectedValue = '1';
  bool isLoading = true;

  final TextEditingController addressController = TextEditingController();

  // late List<ProfileModel>? _profileModel = [];
  Future<List<ProfileModel>?> _getAddress() async {
    setState(() {
      isLoading = true;
    });

    List<ProfileModel>? profileModel =
        (await ProfileApiService().getUserProfile());

    profileModel![0].address == null
        ? addressController.text = ''
        : addressController.text = profileModel[0].address;

    return profileModel;
  }

  Future<List<ProfileModel>?> _updateAddress() async {
    List<ProfileModel>? profileModel =
        (await ProfileApiService().updateUserAddress(addressController.text));
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('address', addressController.text);
    return profileModel;
  }

  @override
  void initState() {
    _getAddress().then((result) {
      setState(() {
        isLoading = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const DrawerMenu(),
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 30),
          child: AppNameWidget(),
        ),
        actions: const [UserCartAppbar(), UserPopupMenu()],
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.orange,
              ),
            )
          : SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('Alamat Saya',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        const SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          controller: addressController,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          minLines: 3,
                          maxLines: 10,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextButton(
                            style: TextButton.styleFrom(
                                side: const BorderSide(
                                    width: 1.5, color: Colors.orange)),
                            onPressed: () async {
                              _updateAddress().then((result) {
                                QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.success,
                                  text: 'Update alamat sukses !',
                                );
                              });
                            },
                            child: const Text(
                              'Simpan',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
