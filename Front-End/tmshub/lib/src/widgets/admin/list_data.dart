import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ListData extends StatelessWidget {
  final String title;
  final String description;
  final String status;

  ListData(
      {required this.title, required this.description, required this.status});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
          width: MediaQuery.of(context).size.width,
          height: 41,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            color: HexColor("#FDA769"),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              Text(
                status,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: status == 'DISETUJUI'
                      ? Color(0xFF33FF99)
                      : status == 'DITOLAK'
                          ? Color(0xFFFB030B)
                          : Color(0xffA8AAAE),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
          width: MediaQuery.of(context).size.width,
          height: 80,
          color: HexColor("#537FE7"),
          child: Text(
            description,
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
        )
      ],
    );
    // return Container(
    //   width: MediaQuery.of(context).size.width,
    //   height: 80,
    //   decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(16), color: Color.fromARGB(255, 75, 194, 255)),
    //   child: Padding(
    //     padding: const EdgeInsets.all(8.0),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Text(
    //               title,
    //               style: TextStyle(fontSize: 18, color: Colors.white),
    //             ),

    //           ],
    //         ),
    //         Text(
    //           description,
    //           style: TextStyle(fontSize: 14, color: Colors.white),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
