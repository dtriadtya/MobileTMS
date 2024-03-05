import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
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

  @override
  void initState() {
    super.initState();
    _getData();
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
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Detail Reimburse',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Jumlah Reimburse: ${reimburseAdmin.amount ?? ''}'),
                      SizedBox(height: 8),
                      Text('Keterangan: ${reimburseAdmin.keterangan ?? ''}'),
                      Row(
                        children: [
                          Text("Lihat Lampiran : "),
                          TextButton(
                            onPressed: () {
                              _showAttachmentDialog(reimburseAdmin);
                            },
                            child: Text("Klik Disini"),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                if (!isStatusApproved && !isStatusRejected)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Aksi ketika tombol "Approve" ditekan
                            Navigator.of(context).pop();
                            _approveReimburse(reimburseAdmin);
                          },
                          child: Text('Approve'),
                        ),
                        SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            // Aksi ketika tombol "Reject" ditekan
                            Navigator.of(context).pop();
                            _rejectReimburse(reimburseAdmin);
                          },
                          child: Text('Reject'),
                        ),
                      ],
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Tutup'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _downloadAttachment(String attachmentUrl) async {
    final taskId = await FlutterDownloader.enqueue(
      url: "${globals.urlAPI}/${attachmentUrl}",
      savedDir: '/storage/emulated/0/Download',
      showNotification: true,
      openFileFromNotification: true,
    );

    FlutterDownloader.registerCallback((id, status, progress) {
      if (status == DownloadTaskStatus.complete) {
        // Unduhan selesai
      } else if (status == DownloadTaskStatus.failed) {
        // Gagal mengunduh
      }
    });
  }

  void _showAttachmentDialog(ReimburseModel reimburseAdmin) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Lampiran',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Aksi ketika tombol "Unduh" ditekan
                    if (reimburseAdmin.lampiran != null) {
                      _downloadAttachment(reimburseAdmin.lampiran!);
                    }
                  },
                  child: Text('Unduh'),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (reimburseAdmin.lampiran != null)
                        Image.network(
                          "${globals.urlAPI}${reimburseAdmin.lampiran}",
                          fit: BoxFit.cover,
                        ),
                      SizedBox(height: 8),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Tutup'),
                      ),
                    ],
                  ),
                ),
              ],
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

  /* void _rejectReimburse(CutiAdmin cutiAdmin) async {
    try {
      await updateCutiStatus(cutiAdmin.idCuti, 'PENDING', 1);
      setState(() {
        cutiAdmin.statusCuti = 'Ditolak';
      });
      print('Status cuti berhasil direject');
    } catch (e) {
      print('Gagal mereject cuti: $e');
    }
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: 10,
        ),
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
                    ReimburseModel reimburseAdmin = reimburseAdminList![index];
                    return GestureDetector(
                      onTap: () {
                        _showReimburseDetailsDialog(reimburseAdmin);
                      },
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                          child: ListData(
                              title: reimburseAdmin.amount ?? '',
                              description: reimburseAdmin.keterangan ?? '',
                              status: reimburseAdmin.statusReimburse ?? '')),
                    );
                  },
                ),
        )
      ],
    ));
  }
}
