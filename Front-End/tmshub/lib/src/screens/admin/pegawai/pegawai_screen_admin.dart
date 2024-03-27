import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tmshub/src/models/user_model.dart';
import 'package:tmshub/src/screens/admin/pegawai/edit_pegawai_screen.dart';
import 'package:tmshub/src/services/user_services.dart';
import 'package:tmshub/src/widgets/admin/grid_data.dart';
import 'package:tmshub/src/utils/globals.dart' as globals;
import 'package:tmshub/src/widgets/top_navigation.dart';
import 'package:tmshub/src/widgets/utility.dart';

class PegawaiScreenAdmin extends StatefulWidget {
  const PegawaiScreenAdmin({Key? key}) : super(key: key);

  @override
  _PegawaiScreenAdminState createState() => _PegawaiScreenAdminState();
}

class _PegawaiScreenAdminState extends State<PegawaiScreenAdmin> {
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

  void _navigateToNextPage(String userId, name, email) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            EditPegawaiScreen(userId: userId, nama: name, email: email),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: users?.length == null
            ? SafeArea(
                child: Column(
                  children: [
                    TopNavigation(title: "Admin Screen Profile"),
                    noContent()
                  ],
                ),
              )
            : SafeArea(
                child: Column(
                  children: [
                    TopNavigation(title: "Admin Screen Profile"),
                    Expanded(
                      child: GridView.builder(
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
                              _navigateToNextPage(user.idUser.toString(),
                                  user.namaUser, user.emailUser);
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
                                      child: Image.asset(
                                        "assets/profile.png",
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
                      ),
                    ),
                  ],
                ),
              ));
  }
}
