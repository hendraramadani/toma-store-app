import 'package:avatar_glow/avatar_glow.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:super_store_e_commerce_flutter/imports.dart';

class CourierHome extends StatefulWidget {
  const CourierHome({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<CourierHome> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final bool _animate = true;
  bool isLoading = false;
  late bool courierActives = false;
  late bool courierAvailables = false;

  @override
  void initState() {
    refreshState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    super.initState();
  }

  void refreshState() {
    _getCourierData().then((result) async {
      //500
      initPrefs().then((result) {
        isLoading = false;
        setState(() {});
      });
    });
  }

  late List<CourierModel>? _courierModel = [];
  Future<List<CourierModel>?> _getCourierData() async {
    isLoading = true;
    _courierModel = (await CourierApiService().getCourier());

    return _courierModel;
  }

  Future<void> updateCourierStatus(statusId) async {
    (await CourierApiService().updateCourierStatus(statusId));

    return;
  }

  Future<void> initPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    ///////
    prefs.setInt('courier_id', _courierModel![0].status[0].id);

    // print(_courierModel![0].status[0].courierStatusActiveId);
    _courierModel![0].status[0].courierStatusActiveId == 1
        ? prefs.setBool('courier_active', true)
        : prefs.setBool('courier_active', false);

    _courierModel![0].status[0].courierStatusAvailableId == 1
        ? prefs.setBool('courier_available', true)
        : prefs.setBool('courier_available', false);

    courierActives = prefs.getBool('courier_active')!;
    courierAvailables = prefs.getBool('courier_available')!;

    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: courierActives == true && courierAvailables == true
          ? const CourierDrawerMenu()
          : null,
      appBar: AppBar(
        title: const AppNameWidget(),
        actions: const [CourierPopupMenu()],
      ),
      body: isLoading == true
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Colors.orange,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text('Loading data')
                ],
              ),
            )
          : Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: ListView(
                  children: [
                    SizedBox(
                      height: 220,
                      child: Card(
                        color: Colors.orange,
                        margin: const EdgeInsets.all(10.0),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(25),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Status Kurir : ${_courierModel![0].status[0].courierStatusActivesName}',
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  courierActives == true
                                      ? _courierModel![0]
                                                  .status[0]
                                                  .courierStatusAvailableId ==
                                              1
                                          ? AvatarGlow(
                                              animate: _animate,
                                              glowColor: const Color.fromARGB(
                                                  255, 0, 255, 8),
                                              child: const Material(
                                                elevation: 2.0,
                                                shape: CircleBorder(),
                                                child: CircleAvatar(
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 0, 255, 8),
                                                  radius: 5,
                                                ),
                                              ),
                                            )
                                          : AvatarGlow(
                                              animate: _animate,
                                              glowColor: Colors.red,
                                              child: const Material(
                                                elevation: 2.0,
                                                shape: CircleBorder(),
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.red,
                                                  radius: 5,
                                                ),
                                              ),
                                            )
                                      : AvatarGlow(
                                          animate: _animate,
                                          glowColor: Colors.red,
                                          child: const Material(
                                            elevation: 2.0,
                                            shape: CircleBorder(),
                                            child: CircleAvatar(
                                              backgroundColor: Colors.red,
                                              radius: 5,
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Status Lapangan : ${courierActives == true ? _courierModel![0].status[0].courierStatusAvailablesName : 'OFF'}',
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              courierActives == true
                                  ? _courierModel![0]
                                              .status[0]
                                              .courierStatusAvailableId ==
                                          3
                                      ? Column(
                                          children: [
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                side: const BorderSide(
                                                    width: 1.5,
                                                    color: Colors.white),
                                              ),
                                              onPressed: () async {
                                                updateCourierStatus(1).then(
                                                  (result) {
                                                    refreshState();
                                                  },
                                                );
                                              },
                                              child: const Text(
                                                'Aktifkan',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            const Text(
                                                'Anda tidak bisa menerima pesanan !')
                                          ],
                                        )
                                      : TextButton(
                                          style: TextButton.styleFrom(
                                              side: const BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          onPressed: () async {
                                            updateCourierStatus(3).then(
                                              (result) {
                                                refreshState();
                                              },
                                            );
                                          },
                                          child: const Text(
                                            'OFF',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                  : const Center(
                                      child: Text(
                                          '* Status kurir Non-Aktif silahkan hubungi admin'))
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
