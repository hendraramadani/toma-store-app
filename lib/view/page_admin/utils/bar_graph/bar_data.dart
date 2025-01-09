import 'package:super_store_e_commerce_flutter/view/page_admin/utils/bar_graph/individual_bar.dart';

class BarData {
  final List jan;
  final List feb;
  final List mar;
  final List apr;
  final List may;
  final List jun;
  final List jul;
  final List aug;
  final List sep;
  final List oct;
  final List nov;
  final List des;

  BarData({
    required this.jan,
    required this.feb,
    required this.mar,
    required this.apr,
    required this.may,
    required this.jun,
    required this.jul,
    required this.aug,
    required this.sep,
    required this.oct,
    required this.nov,
    required this.des,
  });

  List<IndividualBar> barData = [];

  void initializeBarData() {
    barData = [
      IndividualBar(x: 0, y: jan),
      IndividualBar(x: 1, y: feb),
      IndividualBar(x: 2, y: mar),
      IndividualBar(x: 3, y: apr),
      IndividualBar(x: 4, y: may),
      IndividualBar(x: 5, y: jun),
      IndividualBar(x: 6, y: jul),
      IndividualBar(x: 7, y: aug),
      IndividualBar(x: 8, y: sep),
      IndividualBar(x: 9, y: oct),
      IndividualBar(x: 10, y: nov),
      IndividualBar(x: 11, y: des),
    ];
  }
}
