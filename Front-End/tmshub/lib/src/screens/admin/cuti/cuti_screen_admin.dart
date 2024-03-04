import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tmshub/src/models/user_model.dart';
import 'package:tmshub/src/screens/admin/cuti/cuti_admin_detail.dart';
import 'package:tmshub/src/services/user_services.dart';

class CutiScreenAdmin extends StatefulWidget {
  const CutiScreenAdmin({Key? key}) : super(key: key);

  @override
  _CutiScreenAdminState createState() => _CutiScreenAdminState();
}

class _CutiScreenAdminState extends State<CutiScreenAdmin> {
  List<UserModel>? users;

  @override
  void initState() {
    super.initState();
    _getUsers();
  }

  void _getUsers() async {
    try {
      List<UserModel> fetchedUsers = await getAllUsersAPI();
      setState(() {
        users = fetchedUsers;
      });
    } catch (e) {
      print('Failed to get users: $e');
    }
  }

  void _navigateToNextPage(String userId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CutiDetailScreenAdmin(userId: userId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cuti Screen Admin'),
      ),
      body: users?.length == null
          ? Center(
              child: Text("Belum Ada User"),
            )
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Tentukan jumlah kolom dalam grid
                crossAxisSpacing: 8, // Tentukan jarak antar kolom
                mainAxisSpacing: 8, // Tentukan jarak antar baris
              ),
              itemCount: users != null ? users!.length : 0,
              itemBuilder: (BuildContext context, int index) {
                UserModel user = users![index];
                return GestureDetector(
                  onTap: () {
                    _navigateToNextPage(user.idUser.toString());
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 125,
                            height: 125,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(45),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(45),
                              child: Image.asset(
                                "assets/profile.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text(user.namaUser!),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
