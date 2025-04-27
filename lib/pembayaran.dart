import 'package:flutter/material.dart';

class PembayaranPage extends StatefulWidget {
  @override
  _PembayaranPageState createState() => _PembayaranPageState();
}

class _PembayaranPageState extends State<PembayaranPage> {
  final TextEditingController _nomorTujuanController = TextEditingController();
  final TextEditingController _nominalController = TextEditingController();
  String? _jenisPembayaran;

  final List<String> _jenisList = [
    'Pulsa',
    'Listrik',
    'BPJS',
    'Internet',
    'Lainnya'
  ];

  void _konfirmasiPembayaran() {
    final nomor = _nomorTujuanController.text;
    final nominal = _nominalController.text;

    if (_jenisPembayaran == null || nomor.isEmpty || nominal.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Harap isi semua data pembayaran')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Konfirmasi Pembayaran'),
        content: Text(
            'Bayar $_jenisPembayaran ke nomor $nomor sebesar Rp $nominal?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Pembayaran berhasil diproses')),
              );
              _nomorTujuanController.clear();
              _nominalController.clear();
              setState(() {
                _jenisPembayaran = null;
              });
            },
            child: Text('Bayar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pembayaran'),
        backgroundColor: Colors.indigo[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _jenisPembayaran,
              items: _jenisList
                  .map((jenis) => DropdownMenuItem(
                        value: jenis,
                        child: Text(jenis),
                      ))
                  .toList(),
              decoration: InputDecoration(
                labelText: 'Jenis Pembayaran',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _jenisPembayaran = value;
                });
              },
            ),
            SizedBox(height: 16),
            TextField(
              controller: _nomorTujuanController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Nomor Tujuan',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _nominalController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Nominal Pembayaran',
                hintText: 'Contoh: 100000',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: _konfirmasiPembayaran,
              icon: Icon(Icons.payment),
              label: Text('Bayar Sekarang'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                minimumSize: Size.fromHeight(50),
              ),
            )
          ],
        ),
      ),
    );
  }
}
