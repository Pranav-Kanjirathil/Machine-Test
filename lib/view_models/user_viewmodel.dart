import 'package:flutter/material.dart';
import 'package:machine/models/user_model.dart';
import 'package:machine/core/services/user_local_service.dart';

class UserViewModel extends ChangeNotifier {

  final UserLocalService _localService = UserLocalService();

  List<UserModel> _users = [];
  List<UserModel> _displayUsers = [];

  int _selectedFilter = 0;

  List<UserModel> get users => _displayUsers;
  int get selectedFilter => _selectedFilter;

  UserViewModel() {
    loadUsers();
  }

  Future<void> loadUsers() async {

    _users = await _localService.loadUsers();
    _displayUsers = List.from(_users);

    notifyListeners();
  }

  Future<void> addUser(UserModel user) async {

    _users.add(user);
    _applyFilter();

    await _localService.saveUsers(_users);

    notifyListeners();
  }

  void search(String value) {

    _displayUsers = _users.where((user) {
      return user.name
          .toLowerCase()
          .contains(value.toLowerCase());
    }).toList();

    notifyListeners();
  }

  void filter(int type) {

    _selectedFilter = type;

    _applyFilter();

    notifyListeners();
  }

  void _applyFilter() {

    if (_selectedFilter == 0) {
      _displayUsers = List.from(_users);
    }
    else if (_selectedFilter == 1) {
      _displayUsers =
          _users.where((u) => u.age >= 60).toList();
    }
    else {
      _displayUsers =
          _users.where((u) => u.age < 60).toList();
    }

  }

}
