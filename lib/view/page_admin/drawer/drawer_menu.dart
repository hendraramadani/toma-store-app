import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_store_e_commerce_flutter/imports.dart';

class AdminDrawerMenu extends StatefulWidget {
  const AdminDrawerMenu({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<AdminDrawerMenu> {
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
    // double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Drawer(
        width: 300,
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                      height: 150,
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
                            const SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextBuilder(
                                    text: userName,
                                    // fontSize: width * 0.04,
                                    fontWeight: FontWeight.bold),
                                TextBuilder(
                                    text: userEmail,
                                    // fontSize: width * 0.025,
                                    fontWeight: FontWeight.normal),
                              ],
                            ),
                          ],
                        ),
                      )),
                  // const SizedBox(height: 10.0),
                  Expanded(
                    child: ListView(
                      children: [
                        ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const AdminHome()));
                          },
                          leading: Icon(
                            Icons.home_outlined,
                            color: Colors.black,
                          ),
                          title: TextBuilder(
                              text: "Home",
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const AdminStoreMenu()));
                          },
                          leading: Icon(
                            Icons.storefront_outlined,
                            color: Colors.black,
                            // size: width * 0.06,
                          ),
                          title: TextBuilder(
                              text: "Toko & Produk",
                              // fontSize: width * 0.04,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const AdminOrder()));
                          },
                          leading: Icon(
                            Icons.list_alt_outlined,
                            color: Colors.black,
                            // size: width * 0.06,
                          ),
                          title: TextBuilder(
                              text: "Pesanan",
                              // fontSize: width * 0.04,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const AdminCourierMenu()));
                          },
                          leading: Icon(
                            Icons.local_shipping_outlined,
                            color: Colors.black,
                            // size: width * 0.06,
                          ),
                          title: TextBuilder(
                              text: "Kurir",
                              // fontSize: width * 0.04,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const AdminUserMenu()));
                          },
                          leading: Icon(
                            Icons.person_outline,
                            color: Colors.black,
                            // size: width * 0.06,
                          ),
                          title: TextBuilder(
                              text: "Pengguna",
                              // fontSize: width * 0.04,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const AdminMenuReport()));
                          },
                          leading: Icon(
                            Icons.edit_document,
                            color: Colors.black,
                            // size: width * 0.06,
                          ),
                          title: TextBuilder(
                              text: "Laporan",
                              // fontSize: width * 0.04,
                              fontWeight: FontWeight.bold,
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
              height: height * 0.1,
              child: Column(
                children: [
                  const AppNameWidget(),
                  TextBuilder(
                    text: RawString.appDescription,
                    fontSize: 8,
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
