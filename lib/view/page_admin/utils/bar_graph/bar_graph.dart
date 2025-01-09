import 'package:fl_chart/fl_chart.dart';
import 'package:super_store_e_commerce_flutter/imports.dart';
import 'package:super_store_e_commerce_flutter/view/page_admin/utils/bar_graph/bar_data.dart';

class BarGraph extends StatelessWidget {
  final List monthlyOrder;
  const BarGraph({Key? key, required this.monthlyOrder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BarData mybarDataSuccessed = BarData(
        jan: monthlyOrder[0],
        feb: monthlyOrder[1],
        mar: monthlyOrder[2],
        apr: monthlyOrder[3],
        may: monthlyOrder[4],
        jun: monthlyOrder[5],
        jul: monthlyOrder[6],
        aug: monthlyOrder[7],
        sep: monthlyOrder[8],
        oct: monthlyOrder[9],
        nov: monthlyOrder[10],
        des: monthlyOrder[11]);

    mybarDataSuccessed.initializeBarData();
    return BarChart(
      BarChartData(
        maxY: 20,
        minY: 0,
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
              sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getBottomTittles,
          )),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        barGroups: mybarDataSuccessed.barData
            .map(
              (data) => BarChartGroupData(
                x: data.x,
                barRods: [
                  BarChartRodData(
                      toY: data.y[0].toDouble(),
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(3),
                      backDrawRodData: BackgroundBarChartRodData(
                          show: true, toY: 20, color: Colors.orange.shade100)),
                  BarChartRodData(
                      toY: data.y[1].toDouble(),
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(3),
                      backDrawRodData: BackgroundBarChartRodData(
                          show: true, toY: 20, color: Colors.red.shade100))
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}

Widget getBottomTittles(double value, TitleMeta meta) {
  Widget text;

  switch (value.toInt()) {
    case 0:
      text = const Text('Jan');
      break;
    case 1:
      text = const Text('Feb');
      break;
    case 2:
      text = const Text('Mar');
      break;
    case 3:
      text = const Text('Apr');
      break;
    case 4:
      text = const Text('Mei');
      break;
    case 5:
      text = const Text('Jun');
      break;
    case 6:
      text = const Text('Jul');
      break;
    case 7:
      text = const Text('Agu');
      break;
    case 8:
      text = const Text('Sep');
      break;
    case 9:
      text = const Text('Okt');
      break;
    case 10:
      text = const Text('Nov');
      break;
    case 11:
      text = const Text('Des');
      break;
    default:
      text = const Text('');
      break;
  }
  return SideTitleWidget(axisSide: meta.axisSide, child: text);
}
