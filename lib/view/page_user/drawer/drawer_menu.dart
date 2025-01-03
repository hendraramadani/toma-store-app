import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_store_e_commerce_flutter/imports.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  late String userName = '';
  late String userEmail = '';
  Future<int?> getId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userName = prefs.getString('name').toString();
    userEmail = prefs.getString('email').toString();
    return null;
  }

  @override
  void initState() {
    super.initState();
    getId().then((result) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        width: 250,
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                      height: 170.0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.white,
                              backgroundImage:
                                  NetworkImage(RawString.appLogoURL),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextBuilder(
                                    text: userName,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                                TextBuilder(
                                    text: userEmail,
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal),
                              ],
                            ),
                            const SizedBox(width: 10),
                          ],
                        ),
                      )),
                  const SizedBox(height: 10.0),
                  Expanded(
                    child: ListView(
                      children: [
                        ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const UserHome()));
                          },
                          leading: const Icon(
                            Icons.home,
                            color: Colors.black,
                            size: 20,
                          ),
                          title: const TextBuilder(
                              text: "Home",
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const Cart()));
                          },
                          leading: const Icon(
                            Icons.shopping_bag,
                            color: Colors.black,
                            size: 20,
                          ),
                          title: const TextBuilder(
                              text: "Cart",
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const UserOrder()));
                          },
                          leading: const Icon(
                            Icons.playlist_add_check_sharp,
                            color: Colors.black,
                            size: 20,
                          ),
                          title: const TextBuilder(
                              text: "Pesanan Saya",
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 100,
              child: Column(
                children: [
                  const AppNameWidget(),
                  TextBuilder(
                    text: RawString.appDescription,
                    fontSize: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
