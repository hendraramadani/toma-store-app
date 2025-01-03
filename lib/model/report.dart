// To parse this JSON data, do
//
//     final reportModel = reportModelFromJson(jsonString);

import 'dart:convert';

List<ReportModel> reportModelFromJson(String str) => List<ReportModel>.from(
    json.decode(str).map((x) => ReportModel.fromJson(x)));

String reportModelToJson(List<ReportModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReportModel {
  String fileName;
  String filePath;

  ReportModel({
    required this.fileName,
    required this.filePath,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) => ReportModel(
        fileName: json["file_name"],
        filePath: json["file_path"],
      );

  Map<String, dynamic> toJson() => {
        "file_name": fileName,
        "file_path": filePath,
      };
}
