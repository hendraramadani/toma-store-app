import 'package:super_store_e_commerce_flutter/imports.dart';
import 'package:fl_chart/fl_chart.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<AdminHome> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AdminDrawerMenu(),
      appBar:
          AppBar(title: const AppNameWidget(), actions: const [AdminPopMenu()]),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              GridView.count(
                  primary: false,
                  padding: const EdgeInsets.all(15),
                  shrinkWrap: true,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 5,
                  crossAxisCount: 1,
                  children: <Widget>[
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: BarChart(
                          BarChartData(
                            barGroups: [
                              BarChartGroupData(
                                x: 0,
                                barRods: [
                                  BarChartRodData(toY: 8, color: Colors.blue)
                                ],
                              ),
                              BarChartGroupData(
                                x: 1,
                                barRods: [
                                  BarChartRodData(toY: 6, color: Colors.blue)
                                ],
                              ),
                              BarChartGroupData(
                                x: 2,
                                barRods: [
                                  BarChartRodData(toY: 5, color: Colors.blue)
                                ],
                              ),
                              BarChartGroupData(
                                x: 3,
                                barRods: [
                                  BarChartRodData(toY: 10, color: Colors.blue)
                                ],
                              ),
                            ],
                            titlesData: const FlTitlesData(
                              leftTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: true)),
                              bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: true)),
                            ),
                            borderData: FlBorderData(show: true),
                          ),
                        ),
                      ),
                    ),
                    Card(
                        child: PieChart(
                      PieChartData(
                        sections: [
                          PieChartSectionData(
                              value: 40, color: Colors.red, title: 'Red'),
                          PieChartSectionData(
                              value: 30, color: Colors.green, title: 'Green'),
                          PieChartSectionData(
                              value: 30, color: Colors.blue, title: 'Blue'),
                        ],
                        centerSpaceRadius: 40,
                      ),
                    )),
                    Card(
                        child: LineChart(
                      LineChartData(
                        gridData: FlGridData(show: false),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: true)),
                          bottomTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: true)),
                        ),
                        borderData: FlBorderData(show: true),
                        lineBarsData: [
                          LineChartBarData(
                            spots: [
                              FlSpot(0, 1),
                              FlSpot(1, 3),
                              FlSpot(2, 2),
                              FlSpot(3, 5),
                              FlSpot(4, 4),
                            ],
                            isCurved: true,
                            color: Colors.blue,
                            dotData: FlDotData(show: true),
                            belowBarData: BarAreaData(show: false),
                          ),
                        ],
                      ),
                    ))
                  ])
            ],
          ),
        ),
      ),
    );
  }
}
