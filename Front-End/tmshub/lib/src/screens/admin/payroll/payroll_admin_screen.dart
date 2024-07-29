import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tmshub/src/models/user_model.dart';
import 'package:tmshub/src/screens/admin/cuti/cuti_admin_detail.dart';
import 'package:tmshub/src/screens/admin/payroll/payroll_list_admin.dart';
import 'package:tmshub/src/screens/admin/reimburse/reimburse_detail_admin.dart';
import 'package:tmshub/src/services/user_services.dart';
import 'package:tmshub/src/widgets/admin/grid_data.dart';
import 'package:tmshub/src/widgets/top_navigation.dart';
import 'package:tmshub/src/widgets/utility.dart';

class PayrollScreenAdmin extends StatefulWidget {
  const PayrollScreenAdmin({Key? key}) : super(key: key);

  @override
  _PayrollScreenAdminState createState() => _PayrollScreenAdminState();
}

class _PayrollScreenAdminState extends State<PayrollScreenAdmin> {
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

  void _navigateToNextPage(String userId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PayrollListScreenAdmin(userId: userId),
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
                  TopNavigation(title: 'Admin Screen Penggajian'),
                  noContent(),
                ],
              ),
            )
          : SafeArea(
              child: Column(
                children: [
                  TopNavigation(title: 'Admin Screen Penggajian'),
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
                    child: CustomGridView(
                      users: _filterUsers(),
                      ImgaeUrl: "assets/profile.png",
                      onTap: (userId) {
                        _navigateToNextPage(userId);
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
