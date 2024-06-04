import 'package:flutter/material.dart';
import 'package:tmshub/src/models/user_model.dart';
import 'package:tmshub/src/utils/globals.dart' as globals;

class CustomGridView extends StatelessWidget {
  final List<UserModel>? users;
  final Function(String) onTap;
  String ImgaeUrl;

  CustomGridView(
      {required this.users, required this.onTap, required this.ImgaeUrl});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: users != null ? users!.length : 0,
      itemBuilder: (BuildContext context, int index) {
        UserModel user = users![index];
        return GestureDetector(
          onTap: () {
            onTap(user.idUser.toString());
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.network(
                      "${globals.urlAPI}${user.pegawai?.fotoProfil ?? ''}",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  user.namaUser!,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
