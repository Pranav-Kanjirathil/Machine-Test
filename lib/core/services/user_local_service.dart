import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:machine/models/user_model.dart';

class UserLocalService {

  static const String key = "users";

  Future<void> saveUsers(List<UserModel> users) async {

    final prefs = await SharedPreferences.getInstance();

    final data = users.map((e) => e.toJson()).toList();

    await prefs.setString(key, jsonEncode(data));
  }

  Future<List<UserModel>> loadUsers() async {

    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString(key);

    if (data == null) return [];

    List decoded = jsonDecode(data);

    return decoded
        .map((e) => UserModel.fromJson(e))
        .toList();
  }

}
