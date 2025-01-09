import 'package:super_store_e_commerce_flutter/imports.dart';

class AdminCourierMenu extends StatefulWidget {
  const AdminCourierMenu({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _AdminCourierMenuState createState() => _AdminCourierMenuState();
}

class _AdminCourierMenuState extends State<AdminCourierMenu> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: const AdminDrawerMenu(),
      appBar:
          AppBar(title: const AppNameWidget(), actions: const [AdminPopMenu()]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              shrinkWrap: true,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              crossAxisCount: 4,
              children: <Widget>[
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: InkWell(
                    customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    splashColor: const Color.fromARGB(129, 255, 153, 0),
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AdminAddCourier(),
                        ),
                      );
                    },
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.local_shipping_outlined,
                            color: Colors.orange,
                            size: width * 0.05,
                          ),
                          Text(
                            "Tambah",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: width * 0.02,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "Kurir",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: width * 0.02,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: InkWell(
                    customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    splashColor: const Color.fromARGB(129, 255, 153, 0),
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const AdminManageCourier()),
                      );
                    },
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.manage_accounts_outlined,
                            color: Colors.orange,
                            size: width * 0.05,
                          ),
                          Text(
                            "Kelola",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: width * 0.02, color: Colors.black),
                          ),
                          Text(
                            "Kurir",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: width * 0.02, color: Colors.black),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
