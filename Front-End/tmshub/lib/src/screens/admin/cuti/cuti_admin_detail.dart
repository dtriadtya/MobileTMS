import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tmshub/src/models/admin/cuti_model_admin.dart';
import 'package:tmshub/src/services/admin/cuti_admin_service.dart';
import 'package:tmshub/src/utils/globals.dart' as globals;
import 'package:tmshub/src/widgets/admin/list_data.dart';
import 'package:tmshub/src/widgets/modal/custom_dialog.dart';
import 'package:tmshub/src/widgets/top_navigation.dart';

class CutiDetailScreenAdmin extends StatefulWidget {
  final String userId;

  const CutiDetailScreenAdmin({Key? key, required this.userId})
      : super(key: key);

  @override
  _CutiDetailScreenAdminState createState() => _CutiDetailScreenAdminState();
}

class _CutiDetailScreenAdminState extends State<CutiDetailScreenAdmin> {
  List<CutiAdmin>? cutiAdminList;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    try {
      List<CutiAdmin> fetchedCutiAdminList = await getCutiAdminData();
      List<CutiAdmin> filteredCutiAdminList = fetchedCutiAdminList
          .where((cuti) => cuti.idUser == widget.userId)
          .toList();
      setState(() {
        cutiAdminList = filteredCutiAdminList;
      });
    } catch (e) {
      print('Failed to get data: $e');
    }
  }

  void _showCutiDetailsDialog(CutiAdmin cutiAdmin) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        bool isStatusApproved = cutiAdmin.statusCuti == 'DISETUJUI';
        bool isStatusRejected = cutiAdmin.statusCuti == 'DITOLAK';

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
                    'Detail Cuti',
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
                      Text('Jenis Cuti: ${cutiAdmin.jenisCuti ?? ''}'),
                      SizedBox(height: 8),
                      Text('Keterangan: ${cutiAdmin.keterangan ?? ''}'),
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
                            _approveCuti(cutiAdmin);
                          },
                          child: Text('Approve'),
                        ),
                        SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            // Aksi ketika tombol "Reject" ditekan
                            Navigator.of(context).pop();
                            _rejectCuti(cutiAdmin);
                          },
                          child: Text('Reject'),
                        ),
                        SizedBox(width: 8),
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

  _approveCuti(CutiAdmin cutiAdmin) async {
    context.loaderOverlay.show();
    Map<String, String> request = {
      "status_cuti": "DISETUJUI",
      "id_cuti": cutiAdmin.idCuti.toString(),
      "id_admin": globals.userLogin!.idUser.toString(),
    };
    updateCutiStatus(request).then((response) {
      context.loaderOverlay.hide();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
            title: "Sukses Memvalidasi Cuti",
            message: "Berhasil Memvalidasi cuti!",
            type: "success",
          );
        },
      );

      // Memperbarui status cuti dalam daftar cutiAdminList
      setState(() {
        cutiAdmin.statusCuti = 'DISETUJUI';
      });

      // Memperbarui tampilan ListView
      setState(() {});
    }).onError((error, stackTrace) {
      context.loaderOverlay.hide();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
            title: "Gagal Memvalidasi Cuti",
            message: error.toString(),
            type: "failed",
          );
        },
      );
    });
  }

  _rejectCuti(CutiAdmin cutiAdmin) async {
    context.loaderOverlay.show();
    Map<String, String> request = {
      "status_cuti": "DITOLAK",
      "id_cuti": cutiAdmin.idCuti.toString(),
      "id_admin": globals.userLogin!.idUser.toString(),
    };
    updateCutiStatus(request).then((response) {
      context.loaderOverlay.hide();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
            title: "Sukses Memvalidasi Cuti",
            message: "Berhasil Memvalidasi cuti!",
            type: "success",
          );
        },
      );

      // Memperbarui status cuti dalam daftar cutiAdminList
      setState(() {
        cutiAdmin.statusCuti = 'DITOLAK';
      });

      // Memperbarui tampilan ListView
      setState(() {});
    }).onError((error, stackTrace) {
      context.loaderOverlay.hide();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
            title: "Gagal Memvalidasi Cuti",
            message: error.toString(),
            type: "failed",
          );
        },
      );
    });
  }

  /* void _rejectCuti(CutiAdmin cutiAdmin) async {
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
        TopNavigation(title: "Validasi Cuti"),
        Expanded(
          child: cutiAdminList?.length == 0
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
                          textStyle:
                              TextStyle(fontWeight: FontWeight.bold,fontSize: 24),
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: cutiAdminList != null ? cutiAdminList!.length : 0,
                  itemBuilder: (BuildContext context, int index) {
                    CutiAdmin cutiAdmin = cutiAdminList![index];
                    return GestureDetector(
                      onTap: () {
                        _showCutiDetailsDialog(cutiAdmin);
                      },
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                          child: ListData(
                              title: cutiAdmin.jenisCuti ?? '',
                              description: cutiAdmin.keterangan ?? '',
                              status: cutiAdmin.statusCuti ?? '')),
                    );
                  },
                ),
        )
      ],
    ));
  }
}
