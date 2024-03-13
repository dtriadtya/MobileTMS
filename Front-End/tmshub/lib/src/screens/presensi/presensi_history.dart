import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:tmshub/src/models/presensi_model.dart';
import 'package:tmshub/src/services/presensi_services.dart';
import 'package:tmshub/src/utils/globals.dart' as globals;

class PresensiHistoryView extends StatefulWidget {
  @override
  _PresensiHistoryViewState createState() => _PresensiHistoryViewState();
}

class _PresensiHistoryViewState extends State<PresensiHistoryView> {
  Future<List<PresensiModel>>? _presensiFuture;

  @override
  void initState() {
    super.initState();
    _loadPresensi();
  }

  void _loadPresensi() {
    _presensiFuture = fetchPresensiByUser(globals.userLogin!.idUser!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: FutureBuilder<List<PresensiModel>>(
        future: _presensiFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final presensiList = snapshot.data!;
            return ListView.builder(
              itemCount: presensiList.length,
              itemBuilder: (context, index) {
                final presensi = presensiList[index];
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(8, 4, 8, 0),
                    width: MediaQuery.of(context).size.width,
                    height: 125,
                    decoration: BoxDecoration(
                        color: Colors.blueAccent.shade200,
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${DateFormat('EEEE, d MMMM y', 'id_ID').format(presensi.checkIn)}",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Montserrat",
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${DateFormat('h:mm a').format(presensi.checkIn)}',
                              style: TextStyle(
                                  color: HexColor("#000"),
                                  fontFamily: "Montserrat",
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600),
                            ),
                            Chip(
                              label: Text("In"),
                              backgroundColor: HexColor("#28C76F"),
                            )
                          ],
                        ),
                        if (presensi!.checkOut != null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                presensi.checkOut != null
                                    ? '${DateFormat('h:mm a').format(presensi.checkOut!)}'
                                    : '',
                                style: TextStyle(
                                  color: HexColor("#000"),
                                  fontFamily: "Montserrat",
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Chip(
                                label: Text("Out"),
                                backgroundColor: HexColor("#EA5455"),
                              )
                            ],
                          )
                      ],
                    ),
                  ),
                );
                // ListTile(
                //   title: Text('ID Presensi: ${presensi.idPresensi ?? ''}'),
                //   subtitle: Text('Check-in: ${presensi.checkIn ?? ''}'),
                //   trailing: presensi.checkOut != null
                //       ? Text('Check-out: ${presensi.checkOut ?? ''}')
                //       : Text('Belum check-out'),
                // );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
