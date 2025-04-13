import 'package:flutter/material.dart';

class CekSaldoPage extends StatelessWidget {
  final List<Map<String, dynamic>> rekeningList = [
    {
      'nama': 'Rekening Utama',
      'nomor': '1234567890',
      'saldo': 1250000,
    },
    {
      'nama': 'Tabungan Pendidikan',
      'nomor': '0987654321',
      'saldo': 2500000,
    },
  ];

  String _formatRupiah(int amount) {
    return 'Rp ${amount.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cek Saldo'),
      ),
      body: ListView.builder(
        itemCount: rekeningList.length,
        itemBuilder: (context, index) {
          final rekening = rekeningList[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: Icon(Icons.account_balance_wallet, color: Colors.blue),
              title: Text(rekening['nama'], style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('No. Rekening: ${rekening['nomor']}'),
              trailing: Text(
                _formatRupiah(rekening['saldo']),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
              ),
            ),
          );
        },
      ),
    );
  }
}
