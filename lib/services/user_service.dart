import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/user.dart';

class UserService {
  static const String baseUrl = 'https://69561bb3b9b81bad7af22a16.mockapi.io/api/v2/users';

  // GET USER BY ID
  Future<User> getUserById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return User.fromJson(data);
    }
    throw Exception('Gagal mengambil data user');
  }

  // GET ALL USERS
  Future<List<User>> getUsers() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => User.fromJson(e)).toList();
    }
    throw Exception('Gagal mengambil data user');
  }

  // CREATE USER
  Future<void> createUser(Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode != 201) {
      throw Exception('Gagal menambah user');
    }
  }

  // UPDATE USER
  Future<void> updateUser(String id, Map<String, dynamic> body) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode != 200) {
      throw Exception('Gagal update user');
    }
  }

  // DELETE USER
  Future<void> deleteUser(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode != 200) {
      throw Exception('Gagal hapus user');
    }
  }
}
