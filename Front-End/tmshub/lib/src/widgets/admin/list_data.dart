import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ListData extends StatelessWidget {
  final String title;
  final String description;
  final String status;

  ListData({required this.title, required this.description, required this.status});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
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
            SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info, size: 18, color: Colors.grey),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    description,
                    style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}