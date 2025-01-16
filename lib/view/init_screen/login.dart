import 'package:super_store_e_commerce_flutter/imports.dart';
import 'package:super_store_e_commerce_flutter/model/login.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  bool isLoadingLogin = false;
  bool _isObscure = true;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    emailController.text = "admin@mail.com";
    passwordController.text = "admin";
    super.initState();
  }

  late List<LoginModel>? _loginModel = [];
  Future<List<LoginModel>?> _postLoginData() async {
    setState(() {
      isLoadingLogin = true;
    });

    _loginModel = (await LoginApiService()
        .login(emailController.text, passwordController.text));

    return _loginModel;
  }

  @override
  Widget build(BuildContext context) {
    // total height and width of screen
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: isLoadingLogin == true
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
                  Text('Loading Authentication ...')
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
                  children: <Widget>[
                    const SizedBox(height: 50),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 150,
                          child: FittedBox(
                            child: AppNameWidget(),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 150),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: const [AutofillHints.email],
                      validator:
                          ValidationBuilder().email().maxLength(50).build(),
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        prefixIcon: Icon(Icons.mail_outlined),
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
                      validator: ValidationBuilder().minLength(1).build(),
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: const Icon(Icons.lock_outlined),
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
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {},
                        child: const TextBuilder(
                          text: '',
                          fontSize: 16,
                          color: Colors.blue,
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
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _postLoginData().then((result) {
                              print(result![0].success);
                              if (result[0].success == false) {
                                isLoadingLogin = false;
                                setState(() {
                                  QuickAlert.show(
                                    context: context,
                                    type: QuickAlertType.error,
                                    title: 'Login Gagal',
                                    text: 'Login Kredensial Tidak valid !',
                                  );
                                });
                              } else {
                                if (result[0].success == true &&
                                    result[0].accessToken != '' &&
                                    result[0].data!.roleId == 1) {
                                  isLoadingLogin = false;
                                  setState(
                                    () {
                                      QuickAlert.show(
                                        animType: QuickAlertAnimType.slideInUp,
                                        context: context,
                                        barrierDismissible: false,
                                        autoCloseDuration:
                                            const Duration(seconds: 2),
                                        showConfirmBtn: false,
                                        type: QuickAlertType.success,
                                        title: 'Login Berhasil !',
                                      ).then((result) {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    const AdminHome()),
                                            (route) => false);
                                      });
                                    },
                                  );
                                } else if (result[0].success == true &&
                                    result[0].accessToken != '' &&
                                    result[0].data!.roleId == 2) {
                                  isLoadingLogin = false;
                                  setState(
                                    () {
                                      QuickAlert.show(
                                        context: context,
                                        barrierDismissible: false,
                                        autoCloseDuration:
                                            const Duration(seconds: 2),
                                        showConfirmBtn: false,
                                        type: QuickAlertType.success,
                                        title: 'Login Berhasil !',
                                      ).then((result) {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    const CourierHome()),
                                            (route) => false);
                                      });
                                    },
                                  );
                                } else if (result[0].success == true &&
                                    result[0].accessToken != '' &&
                                    result[0].data!.roleId == 3) {
                                  isLoadingLogin = false;
                                  setState(
                                    () {
                                      QuickAlert.show(
                                        context: context,
                                        barrierDismissible: false,
                                        autoCloseDuration:
                                            const Duration(seconds: 2),
                                        showConfirmBtn: false,
                                        type: QuickAlertType.success,
                                        title: 'Login Berhasil !',
                                      ).then((result) {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    const UserHome()),
                                            (route) => false);
                                      });
                                    },
                                  );
                                }
                              }
                            });
                          }
                        },
                        child: const TextBuilder(
                          text: 'Login',
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const TextBuilder(
                          text: "Don't have an account? ",
                          color: Colors.black,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const Register()));
                          },
                          child: const TextBuilder(
                            text: 'Sign Up',
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
