import 'package:flutter/material.dart';

import '../helpers/user_info.dart';
import 'home_page.dart';
import 'admin_page.dart';
import 'login_page.dart';

class AuthCheckPage extends StatefulWidget {
  const AuthCheckPage({super.key});

  @override
  State<AuthCheckPage> createState() => _AuthCheckPageState();
}

class _AuthCheckPageState extends State<AuthCheckPage> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  void _checkAuth() async {
    final userInfo = UserInfo();
    final isLogin = await userInfo.isLogin();
    debugPrint('IS LOGIN: $isLogin');

    if (!isLogin) {
      _go(const LoginPage());
      return;
    }

    final isAdmin = await userInfo.isAdmin();
    debugPrint('IS ADMIN: $isAdmin');

    if (isAdmin) {
      // sementara arahkan ke HomePage dulu
      // nanti diganti AdminPage
      _go(const AdminPage());
    } else {
      _go(const HomePage());
    }
  }

  void _go(Widget page) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
