import 'package:super_store_e_commerce_flutter/imports.dart';
import 'package:super_store_e_commerce_flutter/model/report.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:super_store_e_commerce_flutter/services/dowload_progress.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';

class AdminMenuReport extends StatefulWidget {
  const AdminMenuReport({Key? key}) : super(key: key);

  @override
  _MenuReportState createState() => _MenuReportState();
}

class _MenuReportState extends State<AdminMenuReport> {
  DateTime localTime = DateTime.now().toUtc();

  Future<List<ReportModel>?> reportUserList() async {
    List<ReportModel>? responseData =
        (await ReportApiService().getReportAllUser());
    return responseData;
  }

  Future<List<ReportModel>?> reportCourierList() async {
    List<ReportModel>? responseData =
        (await ReportApiService().getReportAllCourier());
    return responseData;
  }

  Future<List<ReportModel>?> reportOrderList() async {
    List<ReportModel>? responseData =
        (await ReportApiService().getReportAllOrder());
    return responseData;
  }

  Future<List<ReportModel>?> reportSuccessOrderList() async {
    List<ReportModel>? responseData =
        (await ReportApiService().getReportAllSuccessOrder());
    return responseData;
  }

  Future<List<ReportModel>?> reportCancelOrderList() async {
    List<ReportModel>? responseData =
        (await ReportApiService().getReportAllCancelOrder());
    return responseData;
  }

  Future<List<ReportModel>?> reportSuccessOrderListByDate(
      startDate, endDate) async {
    List<ReportModel>? responseData = (await ReportApiService()
        .getReportAllSuccessOrderbyDate(startDate, endDate));
    return responseData;
  }

  Future<List<ReportModel>?> reportCancelOrderListByDate(
      startDate, endDate) async {
    List<ReportModel>? responseData = (await ReportApiService()
        .getReportAllCancelOrderbyDate(startDate, endDate));
    return responseData;
  }

  Future<List<ReportModel>?> reportStoreList() async {
    List<ReportModel>? responseData =
        (await ReportApiService().getReportAllStore());
    return responseData;
  }

  Future<List<ReportModel>?> reportProductList() async {
    List<ReportModel>? responseData =
        (await ReportApiService().getReportAllProduct());
    return responseData;
  }

  List<DateTime?> _dialogCalendarPickerValue = [DateTime.now(), DateTime.now()];

  @override
  Widget build(BuildContext context) {
    final ScaffoldMessengerState downloaded = ScaffoldMessenger.of(context);
    Size size = MediaQuery.sizeOf(context);
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: const AdminDrawerMenu(),
      appBar:
          AppBar(title: const AppNameWidget(), actions: const [AdminPopMenu()]),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        shrinkWrap: true,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        crossAxisCount: 3,
        children: <Widget>[
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              splashColor: const Color.fromARGB(129, 255, 153, 0),
              onTap: () async {
                openDialogAccount(context, size);
              },
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.person,
                      color: Colors.orange,
                      size: width * 0.1,
                    ),
                    Text(
                      "Data Akun",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: width * 0.03,
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
                borderRadius: BorderRadius.circular(10.0)),
            child: InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              splashColor: const Color.fromARGB(129, 255, 153, 0),
              onTap: () async {
                reportOrderList().then(
                  (filePath) async {
                    print(filePath![0].filePath);
                    bool result = await _permissionRequest();
                    if (result) {
                      showDialog(
                          context: context,
                          builder: (dialogcontext) {
                            return DownloadProgressDialog(filePath);
                          });

                      downloaded.showSnackBar(
                        SnackBar(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          backgroundColor: Colors.black,
                          behavior: SnackBarBehavior.floating,
                          content: TextBuilder(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              text: 'Download : ${filePath[0].fileName}'),
                        ),
                      );
                    } else {
                      print("No permission to read and write.");
                    }
                  },
                );
              },
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.list_alt,
                      color: Colors.orange,
                      size: width * 0.1,
                    ),
                    Text(
                      "Semua",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: width * 0.03,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "Pesanan",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: width * 0.03,
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
                borderRadius: BorderRadius.circular(10.0)),
            child: InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              splashColor: const Color.fromARGB(129, 255, 153, 0),
              onTap: () async {
                openDialogSuccessOrder(context, size);
              },
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.list_alt,
                      color: Colors.orange,
                      size: width * 0.1,
                    ),
                    Text(
                      "Pesanan",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: width * 0.03,
                      ),
                    ),
                    Text(
                      "Selesai",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: width * 0.03,
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
                borderRadius: BorderRadius.circular(10.0)),
            child: InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              splashColor: const Color.fromARGB(129, 255, 153, 0),
              onTap: () {
                openDialogCancelOrder(context, size);
              },
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.list_alt,
                      color: Colors.orange,
                      size: width * 0.1,
                    ),
                    Text(
                      "Pesanan",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: width * 0.03,
                      ),
                    ),
                    Text(
                      "Dibatalkan",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: width * 0.03,
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
                borderRadius: BorderRadius.circular(10.0)),
            child: InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              splashColor: const Color.fromARGB(129, 255, 153, 0),
              onTap: () async {
                reportStoreList().then(
                  (filePath) async {
                    print(filePath![0].filePath);
                    bool result = await _permissionRequest();
                    if (result) {
                      showDialog(
                          context: context,
                          builder: (dialogcontext) {
                            return DownloadProgressDialog(filePath);
                          });

                      downloaded.showSnackBar(
                        SnackBar(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          backgroundColor: Colors.black,
                          behavior: SnackBarBehavior.floating,
                          content: TextBuilder(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              text: 'Download : ${filePath[0].fileName}'),
                        ),
                      );
                    } else {
                      print("No permission to read and write.");
                    }
                  },
                );
              },
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.store_mall_directory_outlined,
                      color: Colors.orange,
                      size: width * 0.1,
                    ),
                    const Text(
                      "Toko",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                ),
              ),
            ),
          ),
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              splashColor: const Color.fromARGB(129, 255, 153, 0),
              onTap: () async {
                reportProductList().then(
                  (filePath) async {
                    print(filePath![0].filePath);
                    bool result = await _permissionRequest();
                    if (result) {
                      showDialog(
                          context: context,
                          builder: (dialogcontext) {
                            return DownloadProgressDialog(filePath);
                          });

                      downloaded.showSnackBar(
                        SnackBar(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          backgroundColor: Colors.black,
                          behavior: SnackBarBehavior.floating,
                          content: TextBuilder(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              text: 'Download : ${filePath[0].fileName}'),
                        ),
                      );
                    } else {
                      print("No permission to read and write.");
                    }
                  },
                );
              },
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.local_convenience_store_rounded,
                      color: Colors.orange,
                      size: width * 0.1,
                    ),
                    const Text(
                      "Produk",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Future<bool> _permissionRequest() async {
    PermissionStatus mediaLibrary;
    PermissionStatus storage;

    mediaLibrary = await Permission.mediaLibrary.request();
    storage = await Permission.storage.request();

    if (mediaLibrary.isGranted || storage.isGranted) {
      return true;
    } else {
      return false;
    }
  }

  openDialogSuccessOrder(BuildContext context, Size size) async {
    final ScaffoldMessengerState downloaded = ScaffoldMessenger.of(context);
    double width = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      useSafeArea: true,
      barrierDismissible: true,
      builder: (context) {
        return Center(
          child: AlertDialog(
            actionsPadding: EdgeInsets.zero,
            buttonPadding: EdgeInsets.zero,
            contentPadding: const EdgeInsets.all(10),
            iconPadding: EdgeInsets.zero,
            title: SizedBox(
              width: size.width,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextBuilder(
                    text: "Pilih Laporan",
                    fontWeight: FontWeight.w300,
                  ),
                ],
              ),
            ),
            content: SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        child: InkWell(
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          splashColor: const Color.fromARGB(129, 255, 153, 0),
                          onTap: () async {
                            reportSuccessOrderList().then(
                              (filePath) async {
                                print(filePath![0].filePath);
                                bool result = await _permissionRequest();
                                if (result) {
                                  showDialog(
                                      context: context,
                                      builder: (dialogcontext) {
                                        return DownloadProgressDialog(filePath);
                                      });
                                  downloaded.showSnackBar(
                                    SnackBar(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      backgroundColor: Colors.black,
                                      behavior: SnackBarBehavior.floating,
                                      content: TextBuilder(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          text:
                                              'Download : ${filePath[0].fileName}'),
                                    ),
                                  );
                                } else {
                                  print("No permission to read and write.");
                                }
                              },
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.all(25),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.format_list_numbered,
                                  size: width * 0.09,
                                ),
                                const Text(
                                  "Semua",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                const Text(
                                  "Pesanan",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
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
                            borderRadius: BorderRadius.circular(10.0)),
                        child: InkWell(
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          splashColor: const Color.fromARGB(129, 255, 153, 0),
                          onTap: () async {
                            await showCalendarDatePicker2Dialog(
                              context: context,
                              config:
                                  CalendarDatePicker2WithActionButtonsConfig(
                                calendarType: CalendarDatePicker2Type.range,
                              ),
                              dialogSize: const Size(325, 400),
                              value: _dialogCalendarPickerValue,
                              borderRadius: BorderRadius.circular(15),
                            ).then(
                              (result) {
                                var startDate = result![0];
                                var endDate = result[1]
                                    ?.add(const Duration(hours: 23))
                                    .add(const Duration(minutes: 59))
                                    .add(const Duration(seconds: 59));

                                reportSuccessOrderListByDate(startDate, endDate)
                                    .then(
                                  (filePath) async {
                                    print(filePath![0].filePath);
                                    bool result = await _permissionRequest();
                                    if (result) {
                                      showDialog(
                                          context: context,
                                          builder: (dialogcontext) {
                                            return DownloadProgressDialog(
                                                filePath);
                                          });

                                      downloaded.showSnackBar(
                                        SnackBar(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          backgroundColor: Colors.black,
                                          behavior: SnackBarBehavior.floating,
                                          content: TextBuilder(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w300,
                                              text:
                                                  'Download : ${filePath[0].fileName}'),
                                        ),
                                      );
                                    } else {
                                      print("No permission to read and write.");
                                    }
                                  },
                                );
                              },
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(25),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.calendar_month,
                                  size: width * 0.09,
                                ),
                                const Text(
                                  "Berdasarkan",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                const Text(
                                  "Tanggal",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
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
          ),
        );
      },
    );
  }

  openDialogCancelOrder(BuildContext context, Size size) async {
    final ScaffoldMessengerState downloaded = ScaffoldMessenger.of(context);
    showDialog(
      context: context,
      useSafeArea: true,
      barrierDismissible: true,
      builder: (context) {
        return Center(
          child: AlertDialog(
            actionsPadding: EdgeInsets.zero,
            buttonPadding: EdgeInsets.zero,
            contentPadding: const EdgeInsets.all(10),
            iconPadding: EdgeInsets.zero,
            elevation: 0,
            title: SizedBox(
              width: size.width,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextBuilder(
                    text: "Pilih Laporan",
                    fontWeight: FontWeight.w300,
                  ),
                ],
              ),
            ),
            content: SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        child: InkWell(
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          splashColor: const Color.fromARGB(129, 255, 153, 0),
                          onTap: () async {
                            reportCancelOrderList().then(
                              (filePath) async {
                                print(filePath![0].filePath);
                                bool result = await _permissionRequest();
                                if (result) {
                                  showDialog(
                                      context: context,
                                      builder: (dialogcontext) {
                                        return DownloadProgressDialog(filePath);
                                      });

                                  downloaded.showSnackBar(
                                    SnackBar(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      backgroundColor: Colors.black,
                                      behavior: SnackBarBehavior.floating,
                                      content: TextBuilder(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          text:
                                              'Download : ${filePath[0].fileName}'),
                                    ),
                                  );
                                } else {
                                  print("No permission to read and write.");
                                }
                              },
                            );
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(25),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.format_list_numbered,
                                  size: 30,
                                ),
                                Text(
                                  "Semua",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "Pesanan",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
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
                            borderRadius: BorderRadius.circular(10.0)),
                        child: InkWell(
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          splashColor: const Color.fromARGB(129, 255, 153, 0),
                          onTap: () async {
                            await showCalendarDatePicker2Dialog(
                              context: context,
                              config:
                                  CalendarDatePicker2WithActionButtonsConfig(
                                calendarType: CalendarDatePicker2Type.range,
                              ),
                              dialogSize: const Size(325, 400),
                              value: _dialogCalendarPickerValue,
                              borderRadius: BorderRadius.circular(15),
                            ).then((result) {
                              var startDate = result![0];
                              var endDate = result[1]
                                  ?.add(const Duration(hours: 23))
                                  .add(const Duration(minutes: 59))
                                  .add(const Duration(seconds: 59));

                              reportCancelOrderListByDate(startDate, endDate)
                                  .then(
                                (filePath) async {
                                  print(filePath![0].filePath);
                                  bool result = await _permissionRequest();
                                  if (result) {
                                    showDialog(
                                        context: context,
                                        builder: (dialogcontext) {
                                          return DownloadProgressDialog(
                                              filePath);
                                        });

                                    downloaded.showSnackBar(
                                      SnackBar(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        backgroundColor: Colors.black,
                                        behavior: SnackBarBehavior.floating,
                                        content: TextBuilder(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                            text:
                                                'Download : ${filePath[0].fileName}'),
                                      ),
                                    );
                                  } else {
                                    print("No permission to read and write.");
                                  }
                                },
                              );
                            });
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(25),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.calendar_month,
                                  size: 30,
                                ),
                                Text(
                                  "Berdasarkan",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "Tanggal",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
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
          ),
        );
      },
    );
  }

  openDialogAccount(BuildContext context, Size size) async {
    final ScaffoldMessengerState downloaded = ScaffoldMessenger.of(context);
    showDialog(
      context: context,
      useSafeArea: true,
      barrierDismissible: true,
      builder: (context) {
        return Center(
          child: AlertDialog(
            actionsPadding: EdgeInsets.zero,
            buttonPadding: EdgeInsets.zero,
            contentPadding: const EdgeInsets.all(10),
            iconPadding: EdgeInsets.zero,
            elevation: 0,
            title: SizedBox(
              width: size.width,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextBuilder(
                    text: "Pilih Laporan",
                    fontWeight: FontWeight.w300,
                  ),
                ],
              ),
            ),
            content: SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        child: InkWell(
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          splashColor: const Color.fromARGB(129, 255, 153, 0),
                          onTap: () async {
                            reportUserList().then(
                              (filePath) async {
                                print(filePath![0].filePath);
                                bool result = await _permissionRequest();
                                if (result) {
                                  showDialog(
                                      context: context,
                                      builder: (dialogcontext) {
                                        return DownloadProgressDialog(filePath);
                                      });

                                  downloaded.showSnackBar(
                                    SnackBar(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      backgroundColor: Colors.black,
                                      behavior: SnackBarBehavior.floating,
                                      content: TextBuilder(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          text:
                                              'Download : ${filePath[0].fileName}'),
                                    ),
                                  );
                                } else {
                                  print("No permission to read and write.");
                                }
                              },
                            );
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(25),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.emoji_people,
                                  size: 30,
                                ),
                                Text(
                                  "Pengguna",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
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
                            borderRadius: BorderRadius.circular(10.0)),
                        child: InkWell(
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          splashColor: const Color.fromARGB(129, 255, 153, 0),
                          onTap: () async {
                            reportCourierList().then(
                              (filePath) async {
                                print(filePath![0].filePath);
                                bool result = await _permissionRequest();
                                if (result) {
                                  showDialog(
                                      context: context,
                                      builder: (dialogcontext) {
                                        return DownloadProgressDialog(filePath);
                                      });

                                  downloaded.showSnackBar(
                                    SnackBar(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      backgroundColor: Colors.black,
                                      behavior: SnackBarBehavior.floating,
                                      content: TextBuilder(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          text:
                                              'Download : ${filePath[0].fileName}'),
                                    ),
                                  );
                                } else {
                                  print("No permission to read and write.");
                                }
                              },
                            );
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(25),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.people_alt_outlined,
                                  size: 30,
                                ),
                                Text(
                                  "Kurir      ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
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
          ),
        );
      },
    );
  }
}
