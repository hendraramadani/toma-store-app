import 'package:super_store_e_commerce_flutter/imports.dart';

class UserPopupMenu extends StatefulWidget {
  const UserPopupMenu({Key? key}) : super(key: key);

  @override
  _PopupMenuState createState() => _PopupMenuState();
}

class _PopupMenuState extends State<UserPopupMenu> {
  String selectedValue = '1';

  Future<void> _logout() async {
    (await LogoutApiService().logout());
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      child: const Padding(
        padding: EdgeInsets.only(top: 3, right: 8),
        child: Icon(Icons.settings_outlined),
      ),
      onSelected: (String value) {
        // filterSearchResults(value);
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const UserOrder()));
          },
          value: '1',
          child: const Row(
            children: [
              Icon(
                Icons.playlist_add_check_sharp,
                color: Colors.black,
                size: 20,
              ),
              SizedBox(width: 5),
              Text('Pesanan')
            ],
          ),
        ),
        PopupMenuItem(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const UserProfile()));
          },
          value: '2',
          child: const Row(
            children: [
              Icon(
                Icons.person,
                color: Colors.black,
                size: 20,
              ),
              SizedBox(width: 5),
              Text('Profile')
            ],
          ),
        ),
        PopupMenuItem(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const UserAddress()));
          },
          value: '3',
          child: const Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: Colors.black,
                size: 20,
              ),
              SizedBox(width: 5),
              Text('Alamat')
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
              setState(() {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const Login()),
                    (route) => false);
              });
            });
          },
          value: '4',
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
