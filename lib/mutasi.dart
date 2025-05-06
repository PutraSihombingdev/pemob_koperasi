import 'package:flutter/material.dart';

class MutasiPage extends StatelessWidget {
  const MutasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Mutasi '),
        backgroundColor: Colors.indigo[800],
      ),
      body: const Center(
        child: Text('Ini adalah halaman mutasi'),
      ),
    );
  }
}
