import 'package:super_store_e_commerce_flutter/imports.dart';

class AdminPopMenu extends StatefulWidget {
  const AdminPopMenu({Key? key}) : super(key: key);

  @override
  _PopMenuState createState() => _PopMenuState();
}

class _PopMenuState extends State<AdminPopMenu> {
  Future<void> _logout() async {
    (await LogoutApiService().logout());
  }

  String selectedValue = '1';
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
        // PopupMenuItem(
        //   onTap: () {},
        //   value: '1',
        //   child: const Row(
        //     children: [
        //       Icon(
        //         Icons.person,
        //         color: Colors.black,
        //         size: 20,
        //       ),
        //       SizedBox(width: 5),
        //       Text('Profile')
        //     ],
        //   ),
        // ),
        // PopupMenuItem(
        //   onTap: () {},
        //   value: '2',
        //   child: const Row(
        //     children: [
        //       Icon(
        //         Icons.settings,
        //         color: Colors.black,
        //         size: 20,
        //       ),
        //       SizedBox(width: 5),
        //       Text('Setting')
        //     ],
        //   ),
        // ),
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
                      fontWeight: FontWeight.w300, text: 'Sing Out !'),
                ),
              );
              setState(() {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const Login()),
                    (route) => false);
              });
            });
          },
          value: '1',
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
