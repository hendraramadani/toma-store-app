import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_store_e_commerce_flutter/imports.dart';

class CourierDrawerMenu extends StatefulWidget {
  const CourierDrawerMenu({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<CourierDrawerMenu> {
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
                    height: 150.0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(RawString.appLogoURL),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextBuilder(
                                  text: userName,
                                  // fontSize: 20,
                                  fontWeight: FontWeight.bold),
                              TextBuilder(
                                  text: userEmail,
                                  // fontSize: 10,
                                  fontWeight: FontWeight.normal),
                            ],
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Expanded(
                    child: ListView(
                      children: [
                        ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const CourierHome()));
                          },
                          leading: const Icon(
                            Icons.home_outlined,
                            color: Colors.black,
                            // size: 20,
                          ),
                          title: const TextBuilder(
                              text: "Status Kurir",
                              // fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const ListOrder()));
                          },
                          leading: const Icon(
                            Icons.list_alt,
                            color: Colors.black,
                            // size: 20,
                          ),
                          title: const TextBuilder(
                              text: "List Pesanan",
                              // fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const TakenOrder()));
                          },
                          leading: const Icon(
                            Icons.add_task,
                            color: Colors.black,
                            // size: 20,
                          ),
                          title: const TextBuilder(
                              text: "Pesanan Diambil",
                              // fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const DoneOrder()));
                          },
                          leading: const Icon(
                            Icons.task_outlined,
                            color: Colors.black,
                            // size: 20,
                          ),
                          title: const TextBuilder(
                              text: "Pesanan Selesai",
                              // fontSize: 20.0,
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
