import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'package:path_provider/path_provider.dart';
import 'package:super_store_e_commerce_flutter/model/report.dart';

class FileDownload {
  Dio dio = Dio();
  bool isSuccess = false;

  void startDownloading(
      ReportModel file, BuildContext context, final Function okCallback) async {
    String fileName = file.fileName;

    String baseUrl = file.filePath;

    String path = await _getFilePath(fileName);

    try {
      await dio.download(
        baseUrl,
        path,
        onReceiveProgress: (recivedBytes, totalBytes) {
          okCallback(recivedBytes, totalBytes);
        },
        deleteOnError: true,
      ).then((_) {
        isSuccess = true;
      });
    } catch (e) {
      print("Exception$e");
    }

    if (isSuccess) {
      Navigator.pop(context);
    }
  }

  Future<String> _getFilePath(String filename) async {
    Directory? dir;

    try {
      if (Platform.isIOS) {
        dir = await getApplicationDocumentsDirectory(); // for iOS
      } else {
        dir = Directory('/storage/emulated/0/Download/'); // for android
        if (!await dir.exists()) dir = (await getExternalStorageDirectory())!;
      }
    } catch (err) {
      print("Cannot get download folder path $err");
    }
    return "${dir?.path}$filename";
  }
}
