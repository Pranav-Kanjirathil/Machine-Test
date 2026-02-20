import 'package:flutter/material.dart';
import 'package:machine/models/user_model.dart';
import 'package:machine/core/services/user_local_service.dart';

class UserViewModel extends ChangeNotifier {
  final UserLocalService _localService = UserLocalService();

  List<UserModel> _users = [];
  List<UserModel> _displayUsers = [];

  int _selectedFilter = 0;

  static const int _pageSize = 10;
  int _currentPage = 0;
  bool _isLoading = false;
  bool _hasMore = true;

  List<UserModel> get users => _displayUsers;
  int get selectedFilter => _selectedFilter;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  UserViewModel() {
    loadUsers();
  }

  Future<void> loadUsers() async {
    _isLoading = true;
    _currentPage = 0;
    _users = await _localService.loadUsers();
    _applyFilter();
    _isLoading = false;

    notifyListeners();
  }

  Future<void> loadMore() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500));

    _currentPage++;
    _applyFilter();
    _isLoading = false;

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
      return user.name.toLowerCase().contains(value.toLowerCase());
    }).toList();

    notifyListeners();
  }

  void filter(int type) {
    _selectedFilter = type;

    _applyFilter();

    notifyListeners();
  }

  void _applyFilter() {
    List<UserModel> filtered = [];

    if (_selectedFilter == 0) {
      filtered = _users;
      filtered.sort((a, b) => b.age.compareTo(a.age));
    } else if (_selectedFilter == 1) {
      filtered = _users.where((u) => u.age >= 60).toList();
      filtered.sort((a, b) => b.age.compareTo(a.age));
    } else {
      filtered = _users.where((u) => u.age < 60).toList();
      filtered.sort((a, b) => a.age.compareTo(b.age));
    }

    int startIndex = 0;
    int endIndex = (_currentPage + 1) * _pageSize;
    _displayUsers = filtered.sublist(
      startIndex,
      endIndex > filtered.length ? filtered.length : endIndex,
    );
    _hasMore = endIndex < filtered.length;
  }
}
