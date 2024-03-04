import 'package:flutter/material.dart';

class ListData extends StatelessWidget {
  final String title;
  final String description;
  final String status;

  ListData(
      {required this.title, required this.description, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: Color.fromARGB(255, 75, 194, 255)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                          ? Color(0xff33FF99)
                          : Color(0xffFB030B)),
                ),
              ],
            ),
            Text(
              description,
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
