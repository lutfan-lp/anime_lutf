import 'package:shared_preferences/shared_preferences.dart';

const String TOKEN_KEY = "auth_token";
const String USER_ID = "user_id";
const String USERNAME = "username";
const String IS_ADMIN = "is_admin";

class UserInfo {
  Future setToken(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(TOKEN_KEY, value);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(TOKEN_KEY);
  }

  Future setUserId(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(USER_ID, value);
  }

  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(USER_ID);
  }

  Future setUserName(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(USERNAME, value);
  }

  Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(USERNAME);
  }

  // 🔐 ADMIN ROLE
  Future setIsAdmin(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(IS_ADMIN, value);
  }

  Future<bool> isAdmin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(IS_ADMIN) ?? false;
  }

  // 🔁 AUTO LOGIN
  Future<bool> isLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(TOKEN_KEY) != null;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
