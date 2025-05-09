import 'package:aplikasikoperasiundiksha/login.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void _konfirmasiResetData(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Konfirmasi'),
        content: const Text('Apakah Anda yakin ingin mereset semua data? Tindakan ini tidak dapat dibatalkan.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Tambahkan logika reset data
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Data telah direset')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Reset Mutasi'),
          ),
        ],
      ),
    );
  }

  void _tampilkanTentang(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Aplikasi Koperasi',
      applicationVersion: '1.0.0',
      applicationLegalese: '© 2025 Koperasi Kita',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
        backgroundColor: Colors.blue[900],
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Tentang Aplikasi'),
            leading: const Icon(Icons.info_outline),
            onTap: () => _tampilkanTentang(context),
          ),
          ListTile(
            title: const Text('Reset Data'),
            leading: const Icon(Icons.restore),
            onTap: () => _konfirmasiResetData(context),
          ),
          ListTile(
            title: const Text('Keluar'),
            leading: const Icon(Icons.exit_to_app),
            onTap: () {
              
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
        ],
      ),
    );
  }
}
