import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_store_e_commerce_flutter/imports.dart';

class CourierProfile extends StatefulWidget {
  const CourierProfile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<CourierProfile> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<List<ProductModel>>? futureProduct;
  String selectedValue = '1';
  bool isEdit = false;
  bool isLoading = true;
  late bool courierActives = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // late List<ProfileModel>? _profileModel = [];
  Future<List<ProfileModel>?> _getProfile() async {
    List<ProfileModel>? profileModel =
        (await ProfileApiService().getUserProfile());

    nameController.text = profileModel![0].name;
    emailController.text = profileModel[0].email;
    phoneController.text = profileModel[0].phone;
    passwordController.text = '****';

    return profileModel;
  }

  void initPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    courierActives = prefs.getBool('courier_active')!;
    setState(() {});
  }

  @override
  void initState() {
    initPrefs();
    _getProfile().then(
      (result) {
        isLoading = false;
        setState(() {});
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      key: _scaffoldKey,
      drawer: courierActives == true ? const CourierDrawerMenu() : null,
      appBar: AppBar(
        title: AppNameWidget(),
        centerTitle: true,
        actions: const [CourierPopupMenu()],
      ),
      body: isLoading == true
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Colors.orange,
                  )
                ],
              ),
            )
          : isEdit == false
              ? Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(RawString.appLogoURL),
                    ),
                    Container(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        children: [
                          TextFormField(
                              enabled: false,
                              readOnly: true,
                              controller: nameController,
                              keyboardType: TextInputType.name,
                              autofillHints: const [AutofillHints.name],
                              validator:
                                  ValidationBuilder().minLength(1).build(),
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(top: 15),
                                  prefixIcon: Icon(Icons.person))),
                          TextFormField(
                              enabled: false,
                              readOnly: true,
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              autofillHints: const [AutofillHints.email],
                              validator:
                                  ValidationBuilder().minLength(1).build(),
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(top: 15),
                                  prefixIcon: Icon(Icons.email))),
                          TextFormField(
                              enabled: false,
                              readOnly: true,
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              autofillHints: const [AutofillHints.email],
                              validator:
                                  ValidationBuilder().minLength(1).build(),
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(top: 15),
                                  prefixIcon: Icon(Icons.phone))),
                          TextFormField(
                              enabled: false,
                              readOnly: true,
                              controller: passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              autofillHints: const [AutofillHints.password],
                              validator:
                                  ValidationBuilder().minLength(1).build(),
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(top: 15),
                                  prefixIcon: Icon(Icons.password))),
                        ],
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: MaterialButton(
                            height: 60,
                            color: Colors.orange,
                            minWidth: size.width,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            onPressed: () {
                              isEdit = true;
                              setState(() {});
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextBuilder(
                                  text: 'Edit',
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                ),
                              ],
                            ),
                          ),
                        ))
                  ],
                )
              : Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(RawString.appLogoURL),
                      ),
                      Container(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          children: [
                            TextFormField(
                                controller: nameController,
                                keyboardType: TextInputType.name,
                                autofillHints: const [AutofillHints.name],
                                validator:
                                    ValidationBuilder().minLength(1).build(),
                                decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.only(top: 15),
                                    prefixIcon: Icon(Icons.person))),
                            TextFormField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                autofillHints: const [AutofillHints.email],
                                validator:
                                    ValidationBuilder().minLength(1).build(),
                                decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.only(top: 15),
                                    prefixIcon: Icon(Icons.email))),
                            TextFormField(
                                controller: phoneController,
                                keyboardType: TextInputType.phone,
                                autofillHints: const [AutofillHints.email],
                                validator:
                                    ValidationBuilder().minLength(1).build(),
                                decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.only(top: 15),
                                    prefixIcon: Icon(Icons.phone))),
                            TextFormField(
                                controller: passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                autofillHints: const [AutofillHints.password],
                                validator:
                                    ValidationBuilder().minLength(1).build(),
                                decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.only(top: 15),
                                    prefixIcon: Icon(Icons.password))),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: MaterialButton(
                            height: 60,
                            color: Colors.orange,
                            minWidth: size.width,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            onPressed: () {
                              isEdit = false;
                              setState(() {});
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextBuilder(
                                  text: 'Save',
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
    );
  }
}
