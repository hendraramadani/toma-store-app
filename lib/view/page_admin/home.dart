import 'package:super_store_e_commerce_flutter/imports.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:super_store_e_commerce_flutter/view/page_admin/utils/bar_graph/bar_graph.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<AdminHome> {
  bool isLoading = false;
  List<List<double>> monthlyOrder = [
    [5, 2],
    [10, 7],
    [15, 12],
    [20, 17],
    [25, 23],
    [30, 27],
    [35, 32],
    [40, 37],
    [45, 42],
    [50, 47],
    [55, 52],
    [60, 57]
  ];
  @override
  void initState() {
    initDataPage().then((result) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  late List<List<int>>? monthlyOrderx = [];
  Future<List<List<int>>?> initDataPage() async {
    setState(() {
      isLoading = true;
    });
    print(monthlyOrder[0]);
    monthlyOrderx = (await GraphApiService().getCountOrderByMonth());
    print(monthlyOrderx![0]);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AdminDrawerMenu(),
      appBar:
          AppBar(title: const AppNameWidget(), actions: const [AdminPopMenu()]),
      body: isLoading == true
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  CircularProgressIndicator(
                    color: Colors.orange,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Loading Data ...')
                ],
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text('Data Order Bulanan Tahun 2025')],
                  ),
                  GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(10),
                    shrinkWrap: true,
                    childAspectRatio: (1 / .5),
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 5,
                    crossAxisCount: 1,
                    children: [
                      Card(
                        child: SizedBox(
                          child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Stack(
                                children: [
                                  BarGraph(
                                    monthlyOrder: monthlyOrderx!,
                                  ),
                                ],
                              )),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.square,
                            size: 12,
                            color: (Colors.orange),
                          ),
                          Text('Pesanan Berhasil')
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.square,
                            size: 12,
                            color: (Colors.red),
                          ),
                          Text('Pesanan Dibatalkan')
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
    );
  }
}
