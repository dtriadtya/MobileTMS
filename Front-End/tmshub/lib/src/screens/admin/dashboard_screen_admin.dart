import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tmshub/src/screens/profile/profile_screen.dart';
import 'package:tmshub/src/widgets/dashboard_widgets/dashboard_navigation_admin.dart';
import 'package:tmshub/src/widgets/dashboard_widgets/visi_misi_card.dart';
import 'package:tmshub/src/utils/globals.dart' as globals;

class DashboardScreenAdmin extends StatefulWidget {
  @override
  State<DashboardScreenAdmin> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreenAdmin> {
  @override
  Widget build(BuildContext context) {
    print("dipanggil");
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 210,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(0xff4BC2FF),
                    image: DecorationImage(
                      image: AssetImage('assets/background.png'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        const Color(0xff4BC2FF),
                        BlendMode.multiply,
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color:
                            const Color.fromARGB(255, 0, 0, 0).withOpacity(0.25),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 4),
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset('assets/Logo1.png', width: 130),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("admin Page"),
                                Text(
                                  '${globals.userLogin!.namaUser}'.toUpperCase(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  '${globals.pegawaiLogin != null ? globals.pegawaiLogin!.divisi! : ' '}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  '${globals.pegawaiLogin != null ? globals.pegawaiLogin!.nip ?? ' ' : ' '}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Montserrat',
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: Stack(
                                children: [
                                  ClipOval(
                                    child: Image.network(
                                      globals.urlAPI +
                                          globals.pegawaiLogin!.fotoProfil!,
                                      width: 90,
                                      height: 90,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 50, left: 50),
                                    child: FloatingActionButton.small(
                                      heroTag: "fab_profile",
                                      backgroundColor: HexColor("#E5F1F8"),
                                      child: Icon(Icons.edit_square,
                                          color: Colors.black),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder: (context) {
                                          return ProfileScreen();
                                        })).then((value) {
                                          setState(() {});
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ))
                        ],
                      )
                    ],
                  ),
                ),
                // Card Dasboard
                DasboardNavigationAdminWidget(),
                // visi misi
                VisiMisiCard(),
                SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}