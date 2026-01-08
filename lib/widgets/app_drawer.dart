import 'package:anime_trending_app/ui/login_page.dart';
import 'package:flutter/material.dart';

import '../ui/home_page.dart';
import '../ui/top_anime_page.dart';
import '../ui/top_character_page.dart';
import '../ui/profile_page.dart';
import '../helpers/user_info.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurple, Colors.black],
              ),
            ),
            child: Row(
              children: const [
                Icon(Icons.movie, size: 40, color: Colors.white),
                SizedBox(width: 12),
                Text(
                  'Anime Lutf',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          _drawerItem(
            context,
            icon: Icons.home,
            title: 'Beranda',
            page: const HomePage(),
          ),

          _drawerItem(
            context,
            icon: Icons.trending_up,
            title: 'Top Anime',
            page: const TopAnimePage(),
          ),

          _drawerItem(
            context,
            icon: Icons.people,
            title: 'Top Character',
            page: const TopCharacterPage(),
          ),

          const Divider(),

          _drawerItem(
            context,
            icon: Icons.person,
            title: 'Profil User',
            page: const ProfilePage(),
          ),

          ListTile(
            leading: const Icon(Icons.logout, color: Colors.redAccent),
            title: const Text('Logout'),
            onTap: () async {
              await UserInfo().logout();

              if (!context.mounted) return;

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _drawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Widget page,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => page),
        );
      },
    );
  }
}
