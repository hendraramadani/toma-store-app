import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_store_e_commerce_flutter/imports.dart';

class CourierPopupMenu extends StatefulWidget {
  const CourierPopupMenu({Key? key}) : super(key: key);

  @override
  _PopupMenuState createState() => _PopupMenuState();
}

class _PopupMenuState extends State<CourierPopupMenu> {
  String selectedValue = '1';
  Future<void> _logout() async {
    (await LogoutApiService().logout());
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('courier_active');
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      child: const Padding(
        padding: EdgeInsets.only(top: 3, right: 8),
        child: Icon(Icons.settings_outlined),
      ),
      onSelected: (String value) {
        setState(() {
          selectedValue = value;
        });
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const CourierProfile()));
          },
          value: '1',
          child: const Row(
            children: [
              Icon(
                Icons.person,
                // color: Colors.red,
                size: 20,
              ),
              SizedBox(width: 5),
              Text('Profile')
            ],
          ),
        ),
        PopupMenuItem(
          onTap: () {
            _logout().then((result) {
              final ScaffoldMessengerState logout =
                  ScaffoldMessenger.of(context);
              logout.showSnackBar(
                SnackBar(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  backgroundColor: Colors.black,
                  behavior: SnackBarBehavior.floating,
                  content: const TextBuilder(
                      fontWeight: FontWeight.w300, text: 'Logged Out !'),
                ),
              );
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const Login()),
                  (route) => false);
            });
          },
          value: '2',
          child: const Row(
            children: [
              Icon(
                Icons.logout,
                color: Colors.red,
                size: 20,
              ),
              SizedBox(width: 5),
              Text('Logout')
            ],
          ),
        ),
      ],
    );
  }
}
