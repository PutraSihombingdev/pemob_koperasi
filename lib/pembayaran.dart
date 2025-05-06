import 'package:flutter/material.dart';

class PembayaranPage extends StatelessWidget {
  const PembayaranPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Pembayaran'),
        backgroundColor: Colors.indigo[800],
      ),
      body: const Center(
        child: Text('Ini adalah halaman pembayaran'),
      ),
    );
  }
}
