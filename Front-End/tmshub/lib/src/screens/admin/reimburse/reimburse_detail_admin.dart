import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tmshub/src/models/reimburse_model.dart';
import 'package:tmshub/src/services/reimburse_service.dart';
import 'package:tmshub/src/utils/globals.dart' as globals;
import 'package:tmshub/src/widgets/admin/list_data.dart';
import 'package:tmshub/src/widgets/modal/custom_dialog.dart';
import 'package:tmshub/src/widgets/top_navigation.dart';

class ReimburseDetailScreenAdmin extends StatefulWidget {
  final String userId;

  const ReimburseDetailScreenAdmin({Key? key, required this.userId})
      : super(key: key);

  @override
  _ReimburseDetailScreenAdminState createState() =>
      _ReimburseDetailScreenAdminState();
}

class _ReimburseDetailScreenAdminState
    extends State<ReimburseDetailScreenAdmin> {
  List<ReimburseModel>? reimburseAdminList;
  ReceivePort _port = ReceivePort();
  @override
  void initState() {
    super.initState();
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      setState(() {
        if (status == DownloadTaskStatus.complete) {
          _showSuccesstDialog();
        }
      });
      print("hasil dari status : ${status}");
    });

    FlutterDownloader.registerCallback(downloadCallback);
    _getData();
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }

  void _showSuccesstDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          title: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: 8),
              Text('Download Berhasil', style: GoogleFonts.montserrat(fontWeight: FontWeight.bold)),
            ],
          ),
          content: Text('File telah berhasil diunduh.', style: GoogleFonts.montserrat()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK', style: GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
            ),
          ],
        );
      },
    );
  }

  void _getData() async {
    final id = widget.userId;
    try {
      List<ReimburseModel> fetchedReimburseAdminList =
          await getAllReimburseByUserAPI(int.parse(id));
      List<ReimburseModel> filteredReimburseAdminList =
          fetchedReimburseAdminList
              .where((reimburse) => reimburse.idUser == id)
              .toList();
      setState(() {
        reimburseAdminList = filteredReimburseAdminList;
      });
    } catch (e) {
      print('Failed to get data: $e');
    }
  }

  void _showReimburseDetailsDialog(ReimburseModel reimburseAdmin) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        bool isStatusApproved = reimburseAdmin.statusReimburse == 'DISETUJUI';
        bool isStatusRejected = reimburseAdmin.statusReimburse == 'DITOLAK';

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Detail Reimburse',
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Divider(),
                  SizedBox(height: 8),
                  Text(
                    'Jumlah Reimburse: ${reimburseAdmin.amount ?? ''}',
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Keterangan: ${reimburseAdmin.keterangan ?? ''}',
                    style: GoogleFonts.montserrat(fontSize: 14),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Tanggal Pengajuan: ${DateFormat('d MMMM y').format(reimburseAdmin.tanggalReimburse!)}',
                    style: GoogleFonts.montserrat(fontSize: 14),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text("Lihat Lampiran: ", style: GoogleFonts.montserrat(fontSize: 14)),
                      TextButton(
                        onPressed: () {
                          _showAttachmentDialog(reimburseAdmin);
                        },
                        child: Text("Klik Disini", style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                  if (!isStatusApproved && !isStatusRejected)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Aksi ketika tombol "Approve" ditekan
                            Navigator.of(context).pop();
                            _approveReimburse(reimburseAdmin);
                          },
                          child: Text('Approve', style: GoogleFonts.montserrat()),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                        ),
                        SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            // Aksi ketika tombol "Reject" ditekan
                            Navigator.of(context).pop();
                            _rejectReimburse(reimburseAdmin);
                          },
                          child: Text('Reject', style: GoogleFonts.montserrat()),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Tutup', style: GoogleFonts.montserrat(fontWeight: FontWeight.bold)),
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

  Future<void> downloadFile(String url) async {
    String savePath = '/storage/emulated/0/Download/';
    // Mengunduh file menggunakan flutter_downloader
    await FlutterDownloader.enqueue(
        url: url,
        headers: {}, // optional: header send with url (auth token etc)
        savedDir: savePath,
        showNotification:
            true, // show download progress in status bar (for Android)
        openFileFromNotification:
            true, // click on notification to open downloaded file (for Android)
        saveInPublicStorage: true);
    if (DownloadTaskStatus == DownloadTaskStatus.complete) {
      _showSuccesstDialog();
    }
  }

  void _showAttachmentDialog(ReimburseModel reimburseAdmin) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: HexColor("#FFF8F3F3"),
          shadowColor: HexColor("#7AE5F1F8"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lampiran',
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Divider(),
                  SizedBox(height: 8),
                  if (reimburseAdmin.lampiran != null)
                    Image.network(
                      "${globals.urlAPI}${reimburseAdmin.lampiran}",
                      fit: BoxFit.cover,
                    ),
                  SizedBox(height: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {
                      // Aksi ketika tombol "Unduh" ditekan
                      if (reimburseAdmin.lampiran != null) {
                        downloadFile(
                            "${globals.urlAPI}${reimburseAdmin.lampiran}");
                        if (DownloadTaskStatus == DownloadTaskStatus.complete) {
                          _showSuccesstDialog();
                        }
                      }
                    },
                    child: Text(
                      "Download Lampiran",
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: HexColor("#FFFFFF"),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Tutup', style: GoogleFonts.montserrat(fontWeight: FontWeight.bold)),
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

  _approveReimburse(ReimburseModel reimburseAdmin) async {
    context.loaderOverlay.show();
    Map<String, String> request = {
      "status_reimburse": "DISETUJUI",
      "id_reimburse": reimburseAdmin.idReimburse.toString(),
      "id_admin": globals.userLogin!.idUser.toString(),
    };
    updateReimburseStatus(request).then((response) {
      context.loaderOverlay.hide();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
            title: "Sukses Memvalidasi Pengembalian",
            message: "Berhasil Memvalidasi Pengembalian!",
            type: "success",
          );
        },
      );

      // Memperbarui status reimburse dalam daftar reimburseAdminList
      setState(() {
        reimburseAdmin.statusReimburse = 'DISETUJUI';
      });
    }).onError((error, stackTrace) {
      context.loaderOverlay.hide();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
            title: "Gagal Memvalidasi Pengembalian",
            message: error.toString(),
            type: "error",
          );
        },
      );
    });
  }

  _rejectReimburse(ReimburseModel reimburseAdmin) async {
    context.loaderOverlay.show();
    Map<String, String> request = {
      "status_reimburse": "DITOLAK",
      "id_reimburse": reimburseAdmin.idReimburse.toString(),
      "id_admin": globals.userLogin!.idUser.toString(),
    };
    updateReimburseStatus(request).then((response) {
      context.loaderOverlay.hide();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
            title: "Sukses Memvalidasi Pengembalian",
            message: "Berhasil Memvalidasi Pengembalian!",
            type: "success",
          );
        },
      );

      // Memperbarui status reimburse dalam daftar reimburseAdminList
      setState(() {
        reimburseAdmin.statusReimburse = 'DITOLAK';
      });
    }).onError((error, stackTrace) {
      context.loaderOverlay.hide();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
            title: "Gagal Memvalidasi Pengembalian",
            message: error.toString(),
            type: "error",
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          TopNavigation(title: "Validasi Pengembalian"),
          Expanded(
            child: reimburseAdminList?.length == 0
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/dataNotFound.png",
                          height: 200,
                          width: 200,
                        ),
                        Text(
                          'Data Kosong',
                          style: GoogleFonts.kavoon(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24),
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: reimburseAdminList != null
                        ? reimburseAdminList!.length
                        : 0,
                    itemBuilder: (BuildContext context, int index) {
                      ReimburseModel reimburseAdmin =
                          reimburseAdminList![index];
                      String formattedDate = DateFormat('yyyy-MM-dd')
                          .format(reimburseAdmin!.tanggalReimburse!);
                      return GestureDetector(
                        onTap: () {
                          _showReimburseDetailsDialog(reimburseAdmin);
                        },
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                            child: ListData(
                                title: formattedDate ?? '',
                                description: reimburseAdmin.keterangan ?? '',
                                status: reimburseAdmin.statusReimburse ?? '')),
                      );
                    },
                  ),
          )
        ],
      ),
    ));
  }
}
