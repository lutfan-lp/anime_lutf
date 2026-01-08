import 'package:flutter/material.dart';

import '../helpers/user_info.dart';
import '../models/user.dart';
import '../services/user_service.dart';
import '../widgets/app_drawer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<User> _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = _loadUser();
  }

  Future<User> _loadUser() async {
    final userInfo = UserInfo();
    final userId = await userInfo.getUserId();

    if (userId == null) {
      throw Exception('User belum login');
    }

    return UserService().getUserById(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder<User>(
        future: _userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final user = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(child: Icon(Icons.account_circle, size: 100)),
                const SizedBox(height: 24),

                Text('Username', style: Theme.of(context).textTheme.labelLarge),
                Text(
                  user.userName,
                  style: Theme.of(context).textTheme.titleMedium,
                ),

                const SizedBox(height: 16),

                Text('Email', style: Theme.of(context).textTheme.labelLarge),
                Text(
                  user.email,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
