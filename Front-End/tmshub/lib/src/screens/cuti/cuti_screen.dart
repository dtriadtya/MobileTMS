// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tmshub/src/models/cuti_model.dart';
import 'package:tmshub/src/screens/cuti/cuti_add_screen.dart';
import 'package:tmshub/src/services/cuti_services.dart';
import 'package:tmshub/src/widgets/cuti_widgets/cuti_card.dart';
import 'package:tmshub/src/widgets/modal/custom_dialog.dart';
import 'package:tmshub/src/widgets/top_navigation.dart';
import 'package:tmshub/src/widgets/utility.dart';
import 'package:tmshub/src/utils/globals.dart' as globals;

class CutiScreen extends StatefulWidget {
  const CutiScreen({Key? key}) : super(key: key);
  @override
  _CutiScreenState createState() => _CutiScreenState();
}

class _CutiScreenState extends State<CutiScreen> {
  late bool isExist = false;
  var _isLoaderVisible = true;
  List<CutiModel>? listCuti;
  CutiSisaModel? sisaCuti;

  @override
  void initState() {
    super.initState();
    context.loaderOverlay.show();
    _getCuti();
  }

  void _getCuti() async {
    context.loaderOverlay.show();
    setState(() {
      _isLoaderVisible = context.loaderOverlay.visible;
    });
    await getCutiByUserAPI(globals.userLogin!.idUser).then((value) {
      setState(() {
        listCuti = value;
        isExist = true;
      });
    }).onError((error, stackTrace) {
      context.loaderOverlay.hide();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
            title: "Gagal Memuat Cuti",
            message: error.toString(),
            type: "failed",
          );
        },
      );
    });
    await getSisaCuti(globals.userLogin!.idUser).then((value) => {
          setState(() {
            sisaCuti = CutiSisaModel(
                namaUser: value['nama_user'],
                sisaCuti: value['sisa_cuti'],
                enabled: value['enabled']);
          })
        });
    context.loaderOverlay.hide();
    setState(() {
      _isLoaderVisible = context.loaderOverlay.visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      floatingActionButton: _getFAB(context),
      body: Column(
        children: [
          TopNavigation(title: "pengajuan cuti"),
          SizedBox(
            height: 10,
          ),
          _cutiList()
        ],
      ),
    ));
  }

  Widget _cutiList() {
    if (isExist) {
      if (listCuti!.isNotEmpty) {
        return Expanded(child: SingleChildScrollView(child: screenExist()));
      } else {
        return noContent();
      }
    } else if (!isExist && _isLoaderVisible) {
      return Expanded(child: SizedBox());
    } else {
      return problemNetwork();
    }
  }

  Widget screenExist() {
    return Column(
      children: listCuti!.map((cuti) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          child: CutiCard(
            cuti: cuti,
          ),
        );
      }).toList(),
    );
  }

  Widget _getFAB(BuildContext context) {
    if (isExist) {
      return FloatingActionButton(
          onPressed: () async {
            if (!sisaCuti!.enabled) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomDialog(
                    title: "Tidak Dapat Menambah Cuti",
                    message: "Masih terdapat cuti dengan status pending",
                    type: "failed",
                  );
                },
              );
            } else {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          CutiAddScreen(sisaCuti: sisaCuti))).then((value) {
                if (value == true) {
                  _getCuti();
                }
              });
            }
          },
          backgroundColor: HexColor("#537FE7"),
          isExtended: false,
          child: Icon(
            Icons.add_sharp,
            size: 50,
          ));
    } else {
      return Container();
    }
  }
}
