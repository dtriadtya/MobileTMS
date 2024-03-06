// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tmshub/src/screens/profile/edit_password_screen.dart';
import 'package:tmshub/src/screens/profile/edit_profil_screen.dart';
import 'package:tmshub/src/screens/splash_screen.dart';
import 'package:tmshub/src/services/pegawai_services.dart';
import 'package:tmshub/src/widgets/modal/custom_dialog.dart';
import 'package:tmshub/src/widgets/top_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tmshub/src/utils/globals.dart' as globals;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker picker = ImagePicker();
  XFile? image;
  ImageProvider<Object>? _pic;
  String imageUrl = globals.urlAPI + globals.pegawaiLogin!.fotoProfil!;
  bool isReload = true;

  @override
  void initState() {
    super.initState();
    _pic = NetworkImage(
        imageUrl + "?timestamp=${DateTime.now().millisecondsSinceEpoch}");
    print("masuk");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: "fabcustom",
        isExtended: true,
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EditProfilScreen()))
              .then((value) {
            setState(() {});
          });
        },
        child: Image(
          height: 40,
          image: AssetImage("assets/edit-100.png"),
          filterQuality: FilterQuality.high,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            fit: StackFit.loose,
            children: [
              Container(
                height: 210,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 75, 194, 255),
                  image: DecorationImage(
                    image: AssetImage('assets/background.png'),
                    fit: BoxFit.fitWidth,
                    colorFilter: ColorFilter.mode(
                      const Color.fromARGB(255, 75, 194, 255),
                      BlendMode.multiply,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, top: 10),
                child: TopNavigation(
                  title: "PROFIL",
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 170),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: HexColor("#E5F1F8"),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                ),
                child: profilCard(),
              ),
              Align(
                alignment: AlignmentDirectional.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: CircleAvatar(
                    radius: 70,
                    backgroundColor: HexColor("#E5F1F8"),
                    child: CircleAvatar(
                      radius: 65,
                      backgroundColor: Colors.transparent,
                      backgroundImage: _pic,
                    ),
                  ),
                ),
              ),
              Align(
                  alignment: AlignmentDirectional.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(top: 200, left: 100),
                    child: modalPicture(),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Future getImage(ImageSource media) async {
    var imageFile = await picker.pickImage(source: media);
    context.loaderOverlay.show();
    Map<String, String> request = {
      'id_pegawai': globals.pegawaiLogin!.idPegawai.toString(),
    };
    await changePictureAPI(request, imageFile).then((value) {
      context.loaderOverlay.hide();
      print("object");
      setState(() {});
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
              title: "Berhasil",
              message: "Berhasil mengubah foto!",
              type: "success");
        },
      );
      _pic = NetworkImage(
          imageUrl + "?timestamp=${DateTime.now().millisecondsSinceEpoch}");
    }).onError((error, stackTrace) {
      context.loaderOverlay.hide();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
              title: "Gagal Menyimpan",
              message: error.toString(),
              type: "failed");
        },
      );
    });
  }

  Widget modalPicture() {
    return (FloatingActionButton.small(
      backgroundColor: HexColor("#4BC2FF"),
      onPressed: () {
        showModalBottomSheet<void>(
            context: context,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(40))),
            backgroundColor: HexColor("#4BC2FF"),
            builder: (BuildContext context) {
              return SizedBox(
                height: 250,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 15),
                    Container(
                      width: 50,
                      height: 8,
                      decoration: ShapeDecoration(
                        color: Color(0xFFD9D9D9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _changePictureItem(
                          tittle: "Take a Picture",
                          icon: Icons.camera_alt,
                          onPress: () {
                            Navigator.pop(context);
                            getImage(ImageSource.camera);
                          },
                        ),
                        _changePictureItem(
                          tittle: "Gallery",
                          icon: Icons.folder,
                          onPress: () {
                            Navigator.pop(context);
                            getImage(ImageSource.gallery);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 50)
                  ],
                ),
              );
            });
      },
      child: Icon(Icons.camera_alt_rounded),
    ));
  }

  Widget _changePictureItem(
      {required String tittle, required IconData icon, required onPress}) {
    return InkWell(
      onTap: onPress,
      onDoubleTap: onPress,
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(20),
        dashPattern: const [5, 5],
        color: Colors.black,
        strokeWidth: 2,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(children: [
          Icon(
            icon,
            size: 100,
          ),
          Text(
            tittle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF3D3737),
              fontSize: 14,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w400,
            ),
          ),
        ]),
      ),
    );
  }

  Widget profilCard() {
    return Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _itemDetail(
              tittle: "Nama Lengkap",
              value: globals.userLogin!.namaUser!,
            ),
            _itemDetail(
              tittle: "Alamat",
              value: globals.pegawaiLogin!.alamatPegawai ?? "-",
            ),
            _itemDetail(
              tittle: "Email",
              value: globals.userLogin!.emailUser!,
            ),
            _itemDetail(
              tittle: "No. Telepon",
              value: globals.pegawaiLogin!.nohpPegawai ?? "-",
            ),
            _itemDetail(
              tittle: "Divisi",
              value: globals.pegawaiLogin!.divisi ?? "-",
            ),
            _itemDetail(
              tittle: "Nomor Kepegawaian",
              value: globals.pegawaiLogin!.nip ?? "-",
            ),
            SizedBox(height: 12),
            SizedBox(
              width: double.maxFinite,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditPasswordScreen()));
                },
                child: Text(
                  "Ganti kata sandi",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: HexColor("#FFFFFF"),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12),
            SizedBox(
              width: double.maxFinite,
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  _modalLogout();
                },
                child: Text(
                  "Logout",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: HexColor("#FFFFFF"),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ));
  }

  Widget _itemDetail({required String tittle, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tittle,
          style: TextStyle(
            fontFamily: "Montserrat",
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: HexColor("#4D4848"),
          ),
        ),
        SizedBox(height: 8),
        Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: HexColor("#4D4848"), width: 1),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontFamily: "Montserrat",
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(height: 12),
      ],
    );
  }

  void _cleanSharredPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("userLogin", json.encode(null));
    prefs.setString("pegawaiLogin", json.encode(null));
    prefs.setBool("isLogin", false);
  }

  void _modalLogout() {
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
            child: Container(
              constraints: BoxConstraints(maxHeight: 300),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 36),
                    Icon(
                      Icons.logout_outlined,
                      size: 100,
                      color: Colors.red,
                    ),
                    SizedBox(height: 32),
                    Text(
                      "Apakah anda yakin ?",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: HexColor("#994B465C"),
                      ),
                    ),
                    SizedBox(height: 40),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                            fit: FlexFit.tight,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red.shade700),
                              onPressed: () {
                                _cleanSharredPreferences();
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SplashScreen()),
                                    (Route route) => false);
                              },
                              child: Text(
                                "Keluar",
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                              ),
                            )),
                        SizedBox(width: 10),
                        Flexible(
                            fit: FlexFit.tight,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Batal",
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                              ),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
