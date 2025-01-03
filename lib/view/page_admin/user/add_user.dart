import 'package:super_store_e_commerce_flutter/imports.dart';

class AdminAddUser extends StatefulWidget {
  const AdminAddUser({Key? key}) : super(key: key);

  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AdminAddUser> {
  late bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController =
      TextEditingController();

  // late List<RegisterModel>? _registerModel = [];
  Future<List<RegisterModel>?> _postRegisterData() async {
    setState(() {
      isLoading = true;
    });
    List<RegisterModel>? data = (await RegisterApiService().register(
        nameController.text,
        emailController.text,
        phoneController.text,
        passwordController.text,
        passwordConfirmationController.text,
        3));

    return data;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      drawer: const AdminDrawerMenu(),
      appBar:
          AppBar(title: const AppNameWidget(), actions: const [AdminPopMenu()]),
      body: Form(
        key: _formKey,
        child: isLoading == true
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
            : SingleChildScrollView(
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
                        hintText: 'Nama',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: const [AutofillHints.email],
                      validator:
                          ValidationBuilder().email().maxLength(50).build(),
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        prefixIcon: Icon(Icons.mail),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      validator:
                          ValidationBuilder().phone().minLength(10).build(),
                      decoration: const InputDecoration(
                        hintText: 'No. HP',
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: passwordController,
                      obscureText: _isObscure,
                      validator: ValidationBuilder().minLength(8).build(),
                      decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(_isObscure
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: passwordConfirmationController,
                      obscureText: _isObscure,
                      validator: ValidationBuilder().minLength(8).build(),
                      decoration: InputDecoration(
                        hintText: 'Konfirmasi Password',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(_isObscure
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
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
                            _postRegisterData().then(
                              (result) {
                                isLoading = false;
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
                                setState(
                                  () {
                                    nameController.clear();
                                    emailController.clear();
                                    phoneController.clear();
                                    passwordController.clear();
                                    passwordConfirmationController.clear();
                                  },
                                );
                              },
                            );
                          }
                          // Navigator.pushAndRemoveUntil(
                          //     context,
                          //     MaterialPageRoute(builder: (_) => const Login()),
                          //     (route) => false);
                        },
                        child: const TextBuilder(
                          text: 'Tambah Pengguna',
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
