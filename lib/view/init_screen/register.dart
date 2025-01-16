import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:super_store_e_commerce_flutter/imports.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController =
      TextEditingController();

  Future<List<RegisterModel>?> _postRegisterData() async {
    List<RegisterModel>? registerModel = (await RegisterApiService().register(
        nameController.text,
        emailController.text,
        phoneController.text,
        passwordController.text,
        passwordConfirmationController.text,
        3));

    return registerModel;
  }

  @override
  Widget build(BuildContext context) {
    // total height and width of screen
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
              const SizedBox(height: 75),
              TextFormField(
                controller: nameController,
                keyboardType: TextInputType.name,
                autofillHints: const [AutofillHints.name],
                validator: ValidationBuilder().minLength(1).build(),
                decoration: const InputDecoration(
                  hintText: 'Nama',
                  prefixIcon: Icon(Icons.person_outline),
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
                validator: ValidationBuilder().email().maxLength(50).build(),
                decoration: const InputDecoration(
                  hintText: 'Email',
                  prefixIcon: Icon(Icons.mail_outline),
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
                validator: ValidationBuilder().phone().minLength(10).build(),
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
                controller: passwordController,
                obscureText: _isObscure,
                validator: ValidationBuilder().minLength(8).build(),
                decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off),
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
                  hintText: 'Confirm Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off),
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
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _postRegisterData().then((result) {
                        nameController.clear();
                        emailController.clear();
                        phoneController.clear();
                        passwordController.clear();
                        passwordConfirmationController.clear();
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.success,
                          text: 'Registrasi  Sukses !',
                        );
                      });
                    }
                  },
                  child: const TextBuilder(
                    text: 'Sign Up',
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
                    text: "Have have an account? ",
                    color: Colors.black,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const Login()));
                    },
                    child: const TextBuilder(
                      text: 'Login',
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
