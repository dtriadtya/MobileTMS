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
  String _searchQuery = '';
  String _selectedRole = '1'; // Default filter
  bool _isAscending = true;

  @override
  void initState() {
    super.initState();
    _getUsers();
  }

  void _getUsers() async {
    try {
      List<UserModel> fetchedUsers = await getAllUsersAPI();
      List<UserModel> filteredUsers =
          fetchedUsers.where((user) => user.role == _selectedRole).toList();
      setState(() {
        users = filteredUsers;
        _sortUsers(); // Sort users after fetching
      });
    } catch (e) {
      print('Failed to get users: $e');
    }
  }

  void _navigateToNextPage(String userId, String name, String email) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            EditPegawaiScreen(userId: userId, nama: name, email: email),
      ),
    );
  }

  void _updateSearchQuery(String newQuery) {
    setState(() {
      _searchQuery = newQuery;
    });
  }

  void _updateSelectedRole(String newRole) {
    setState(() {
      _selectedRole = newRole;
      _getUsers(); // Update users based on selected role
    });
  }

  void _toggleSortOrder() {
    setState(() {
      _isAscending = !_isAscending;
      _sortUsers();
    });
  }

  void _sortUsers() {
    users?.sort((a, b) {
      int compare = a.namaUser!.compareTo(b.namaUser!);
      return _isAscending ? compare : -compare;
    });
  }

  List<UserModel> _filterUsers() {
    if (users == null) return [];
    return users!
        .where((user) =>
            user.namaUser!.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: users == null
          ? SafeArea(
              child: Column(
                children: [
                  TopNavigation(title: 'Admin Screen Profile'),
                  noContent(),
                ],
              ),
            )
          : SafeArea(
              child: Column(
                children: [
                  TopNavigation(title: 'Admin Screen Profile'),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search by name',
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            onChanged: _updateSearchQuery,
                          ),
                        ),
                        IconButton(
                          icon: Icon(_isAscending
                              ? Icons.arrow_downward
                              : Icons.arrow_upward),
                          onPressed: _toggleSortOrder,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: _filterUsers().length,
                      itemBuilder: (BuildContext context, int index) {
                        UserModel user = _filterUsers()[index];
                        return GestureDetector(
                          onTap: () {
                            _navigateToNextPage(user.idUser.toString(),
                                user.namaUser!, user.emailUser!);
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
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
