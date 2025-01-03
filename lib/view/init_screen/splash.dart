import 'package:super_store_e_commerce_flutter/imports.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _getLoginData().then((result) {
      getData();
    });
    // Future.delayed(const Duration(seconds: 1)).then((value) => getData());
  }

  dynamic token;
  var role;

  Future _getLoginData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
      role = prefs.getInt('role');
    });
  }

  getData() {
    if (token != null && role == 1) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const AdminHome()),
          (route) => false);
    } else if (token != null && role == 2) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const CourierHome()),
          (route) => false);
    } else if (token != null && role == 3) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const UserHome()),
          (route) => false);
    } else {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => const Login()), (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
