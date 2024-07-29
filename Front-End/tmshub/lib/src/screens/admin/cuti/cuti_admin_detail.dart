import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tmshub/src/models/admin/cuti_model_admin.dart';
import 'package:tmshub/src/services/admin/cuti_admin_service.dart';
import 'package:tmshub/src/utils/globals.dart' as globals;
import 'package:tmshub/src/widgets/admin/list_data.dart';
import 'package:tmshub/src/widgets/modal/custom_dialog.dart';
import 'package:tmshub/src/widgets/top_navigation.dart';
import 'package:tmshub/src/widgets/utility.dart';

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
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Detail Cuti',
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildDetailItem('Tanggal Mulai Cuti', DateFormat('d MMMM y').format(cutiAdmin.tglMulai!)),
                  _buildDetailItem('Tanggal Akhir Cuti', DateFormat('d MMMM y').format(cutiAdmin.tglAkhir!)),
                  _buildDetailItem('Jenis Cuti', cutiAdmin.jenisCuti ?? ''),
                  _buildDetailItem('Keterangan', cutiAdmin.keterangan ?? ''),
                  if (!isStatusApproved && !isStatusRejected)
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              _approveCuti(cutiAdmin);
                            },
                            child: Text('Approve'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                          ),
                          SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              _rejectCuti(cutiAdmin);
                            },
                            child: Text('Reject'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Tutup'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
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

      setState(() {
        cutiAdmin.statusCuti = 'DISETUJUI';
      });
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

      setState(() {
        cutiAdmin.statusCuti = 'DITOLAK';
      });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TopNavigation(title: "Validasi Cuti"),
            Expanded(
              child: cutiAdminList?.isEmpty ?? true
                  ? noContent()
                  : ListView.builder(
                      itemCount: cutiAdminList?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        CutiAdmin cutiAdmin = cutiAdminList![index];
                        return GestureDetector(
                          onTap: () {
                            _showCutiDetailsDialog(cutiAdmin);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListData(
                              title: cutiAdmin.jenisCuti ?? '',
                              description: cutiAdmin.keterangan ?? '',
                              status: cutiAdmin.statusCuti ?? '',
                            ),
                          ),
                        );
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}
