import 'package:flutter/material.dart';

import '../models/user.dart';
import '../services/user_service.dart';

class UserFormPage extends StatefulWidget {
  final User? user;

  const UserFormPage({super.key, this.user});

  @override
  State<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      nameCtrl.text = widget.user!.userName;
      emailCtrl.text = widget.user!.email;
      passCtrl.text = widget.user!.password;
    }
  }

  void _submit() async {
    final body = {
      "user_name": nameCtrl.text,
      "email": emailCtrl.text,
      "password": passCtrl.text,
    };

    if (widget.user == null) {
      await UserService().createUser(body);
    } else {
      await UserService().updateUser(widget.user!.id, body);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user == null ? 'Tambah User' : 'Edit User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: emailCtrl,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passCtrl,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submit,
                child: const Text('SIMPAN'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
