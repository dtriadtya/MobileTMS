import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tmshub/src/models/user_model.dart';
import 'package:tmshub/src/screens/admin/presensi/presensi_history_admin.dart';
import 'package:tmshub/src/services/user_services.dart';
import 'package:tmshub/src/widgets/admin/grid_data.dart';
import 'package:tmshub/src/utils/globals.dart' as globals;

class PresensiScreenAdmin extends StatefulWidget {
  const PresensiScreenAdmin({Key? key}) : super(key: key);

  @override
  _PresensiScreenAdminState createState() => _PresensiScreenAdminState();
}

class _PresensiScreenAdminState extends State<PresensiScreenAdmin> {
  List<UserModel>? users;

  @override
  void initState() {
    super.initState();
    _getUsers();
  }

  void _getUsers() async {
    try {
      List<UserModel> fetchedUsers = await getAllUsersAPI();
      List<UserModel> filteredUsers =
          fetchedUsers.where((user) => user.role == "1").toList();
      setState(() {
        users = filteredUsers;
      });
    } catch (e) {
      print('Failed to get users: $e');
    }
  }

  void _navigateToNextPage(String userId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PresensiHistoryView(userId: userId,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Reimburse Screen Admin'),
        ),
        body: users?.length == null
            ? Center(
                child: Text("Belum Ada User"),
              )
            : CustomGridView(
                users: users,
                ImgaeUrl:"assets/profile.png" , // Berikan daftar pengguna ke properti users
                onTap: (userId) {
                  // Lakukan tindakan yang sesuai ketika salah satu item di-tap
                  _navigateToNextPage(userId);
                },
              ));
  }
}
