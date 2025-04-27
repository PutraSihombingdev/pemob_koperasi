import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String namaLengkap = "Putra Sihombing";
  final String email = "putra@example.com";
  final String nomorHp = "0812-3456-7890";
  final String username = "putrasihombing";

  void _showEditProfile(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Fitur edit profil belum tersedia')),
    );
  }

  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Konfirmasi Logout'),
        content: Text('Apakah kamu yakin ingin keluar?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Navigasi kembali ke login atau halaman awal
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Berhasil logout')),
              );
            },
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Pengguna'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => _showEditProfile(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Icon(Icons.account_circle, size: 100, color: Colors.grey)),
                SizedBox(height: 20),
                Text('Nama Lengkap:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(namaLengkap),
                SizedBox(height: 10),
                Text('Email:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(email),
                SizedBox(height: 10),
                Text('No. HP:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(nomorHp),
                SizedBox(height: 10),
                Text('Username:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(username),
                SizedBox(height: 30),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () => _logout(context),
                    icon: Icon(Icons.logout),
                    label: Text('Logout'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      minimumSize: Size.fromHeight(50),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
