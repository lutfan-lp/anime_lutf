import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../helpers/user_info.dart';
import '../models/user.dart';

class LoginService {
  static const String baseUrl =
      'https://69561bb3b9b81bad7af22a16.mockapi.io/api/v2';
  // ⚠️ ganti dengan BASE URL project mockAPI kamu (tanpa /users di akhir)

  // ADMIN HARDCODE
  final String adminEmail = 'admin@gmail.local';
  final String adminPassword = 'admin';

  Future<User?> login(String email, String password) async {
    // 🔐 ADMIN LOGIN
    if (email == adminEmail && password == adminPassword) {
      debugPrint('ADMIN LOGIN SUCCESS');
      await UserInfo().setToken('admin_token');
      await UserInfo().setUserId('0');
      await UserInfo().setUserName('Administrator');
      await UserInfo().setIsAdmin(true);
      return User(
        id: 0.toString(),
        userName: 'Administrator',
        email: adminEmail,
        password: adminPassword,
      );
    }

    // 🔁 USER LOGIN
    try {
      final response = await http.get(Uri.parse('$baseUrl/users'));

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);

        for (var item in data) {
          if (item['email'] == email && item['password'] == password) {
            final user = User.fromJson(item);
            // simpan session
            await UserInfo().setToken('token_${user.id}');
            await UserInfo().setUserId(user.id);
            await UserInfo().setUserName(user.userName);
            await UserInfo().setIsAdmin(false);

            return user;
          }
        }
      }
      return null;
    } catch (e) {
      debugPrint('Login error: $e');
      return null;
    }
  }
}
