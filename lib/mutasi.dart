import 'package:flutter/material.dart';

class MutasiPage extends StatelessWidget {
  final List<Map<String, dynamic>> _mutasiData = [
    {
      'tanggal': '10 Apr 2025',
      'keterangan': 'Transfer Masuk',
      'jumlah': 1000000,
      'tipe': 'masuk',
    },
    {
      'tanggal': '11 Apr 2025',
      'keterangan': 'Tarik Tunai',
      'jumlah': 250000,
      'tipe': 'keluar',
    },
    {
      'tanggal': '12 Apr 2025',
      'keterangan': 'Deposito',
      'jumlah': 500000,
      'tipe': 'keluar',
    },
    {
      'tanggal': '13 Apr 2025',
      'keterangan': 'Transfer Masuk',
      'jumlah': 750000,
      'tipe': 'masuk',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mutasi Rekening'),
        backgroundColor: Colors.indigo[800],
      ),
      body: ListView.builder(
        itemCount: _mutasiData.length,
        itemBuilder: (context, index) {
          final mutasi = _mutasiData[index];
          final warna = mutasi['tipe'] == 'masuk' ? Colors.green : Colors.red;
          final simbol = mutasi['tipe'] == 'masuk' ? '+' : '-';

          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 2,
            child: ListTile(
              leading: Icon(
                mutasi['tipe'] == 'masuk'
                    ? Icons.arrow_downward
                    : Icons.arrow_upward,
                color: warna,
              ),
              title: Text(mutasi['keterangan']),
              subtitle: Text(mutasi['tanggal']),
              trailing: Text(
                '$simbol Rp ${mutasi['jumlah'].toString()}',
                style: TextStyle(color: warna, fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }
}
