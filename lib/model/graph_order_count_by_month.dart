// To parse this JSON data, do
//
//     final orderCountByMonth = orderCountByMonthFromJson(jsonString);

import 'dart:convert';

List<List<int>> orderCountByMonthFromJson(String str) => List<List<int>>.from(
    json.decode(str).map((x) => List<int>.from(x.map((x) => x))));

String orderCountByMonthToJson(List<List<int>> data) => json.encode(
    List<dynamic>.from(data.map((x) => List<dynamic>.from(x.map((x) => x)))));
