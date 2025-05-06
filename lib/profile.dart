import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Profile'),
        backgroundColor: Colors.indigo[800],
      ),
      body: const Center(
        child: Text('Ini adalah halaman Profile'),
      ),
    );
  }
}
