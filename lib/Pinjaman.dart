import 'package:flutter/material.dart';

class PinjamanPage extends StatelessWidget {
  const PinjamanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Pinjaman'),
        backgroundColor: Colors.indigo[800],
      ),
      body: const Center(
        child: Text('Ini adalah halaman pinjaman'),
      ),
    );
  }
}
