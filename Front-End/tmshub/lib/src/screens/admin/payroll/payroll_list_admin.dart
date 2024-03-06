import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tmshub/src/models/admin/cuti_model_admin.dart';
import 'package:tmshub/src/models/penggajian_model.dart';
import 'package:tmshub/src/services/admin/cuti_admin_service.dart';
import 'package:tmshub/src/services/penggajian_services.dart';
import 'package:tmshub/src/utils/globals.dart' as globals;
import 'package:tmshub/src/widgets/admin/list_data.dart';
import 'package:tmshub/src/widgets/modal/custom_dialog.dart';
import 'package:tmshub/src/widgets/top_navigation.dart';

class PayrollListScreenAdmin extends StatefulWidget {
  final String userId;

  const PayrollListScreenAdmin({Key? key, required this.userId})
      : super(key: key);

  @override
  _PayrollListScreenAdminState createState() => _PayrollListScreenAdminState();
}

class _PayrollListScreenAdminState extends State<PayrollListScreenAdmin> {
  List<PenggajianModel>? penggajianAdminList;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    try {
      List<PenggajianModel> fetchedPenggajianAdminList = await getPenggajianByUserAPI(widget.userId as int);
      List<PenggajianModel>? filteredCutiAdminList = penggajianAdminList;
      setState(() {
        penggajianAdminList = filteredCutiAdminList;
      });
    } catch (e) {
      print('Failed to get data: $e');
    }
  }


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
          child: penggajianAdminList?.length == 0
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
                  itemCount: penggajianAdminList != null ? penggajianAdminList!.length : 0,
                  itemBuilder: (BuildContext context, int index) {
                    PenggajianModel penggajianAdmin = penggajianAdminList![index];
                    return Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                        child: ListData(
                            title: penggajianAdmin.tanggal.toString(),
                            description: penggajianAdmin.keterangan ?? '',
                            status: penggajianAdmin.statusGaji ?? ''));
                  },
                ),
        )
      ],
    ));
  }
}
