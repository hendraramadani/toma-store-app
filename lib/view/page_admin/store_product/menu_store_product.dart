import 'package:super_store_e_commerce_flutter/imports.dart';

class AdminStoreMenu extends StatefulWidget {
  const AdminStoreMenu({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _AdminStoreMenuState createState() => _AdminStoreMenuState();
}

class _AdminStoreMenuState extends State<AdminStoreMenu> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: const AdminDrawerMenu(),
      appBar: AppBar(
        centerTitle: true,
        title: const AppNameWidget(),
        actions: const [AdminPopMenu()],
      ),
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
                          builder: (_) => const AdminAddStore(),
                        ),
                      );
                    },
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          FittedBox(
                            fit: BoxFit.contain,
                            child: Icon(
                              Icons.storefront,
                              color: Colors.orange,
                              size: width * 0.05,
                            ),
                          ),
                          FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                "Tambah",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: width * 0.02,
                                  color: Colors.black,
                                ),
                              )),
                          FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                "Toko",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: width * 0.02,
                                    color: Colors.black),
                              )),
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
                          builder: (_) => const ManageStore(),
                        ),
                      );
                    },
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.settings_applications_sharp,
                            color: Colors.orange,
                            size: width * 0.05,
                          ),
                          Text(
                            "Kelola",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: width * 0.02,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "Toko",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: width * 0.02, color: Colors.black),
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
                          builder: (_) => const AdminAddProduct(),
                        ),
                      );
                    },
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.store_outlined,
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
                            "Produk",
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
                          builder: (_) => const ManageProduct(),
                        ),
                      );
                    },
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.settings_applications,
                            color: Colors.orange,
                            size: width * 0.05,
                          ),
                          Text(
                            "Kelola",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: width * 0.02,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "Produk",
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
