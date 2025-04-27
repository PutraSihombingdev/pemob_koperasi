import 'package:flutter/material.dart';

class TransferPage extends StatefulWidget {
  @override
  _TransferPageState createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  final TextEditingController _nomorRekeningController = TextEditingController();
  final TextEditingController _nominalController = TextEditingController();
  final TextEditingController _beritaController = TextEditingController();

  String? _selectedRekeningAsal;
  final List<String> _rekeningList = [
    'Rekening Utama - 1234',
    'Tabungan - 5678',
    'Buat Belanja - 50123'
  ];

  void _konfirmasiTransfer() {
    final rekeningTujuan = _nomorRekeningController.text.trim();
    final nominal = _nominalController.text.trim();
    final berita = _beritaController.text.trim();

    if (_selectedRekeningAsal == null || rekeningTujuan.isEmpty || nominal.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Harap isi semua data yang diperlukan')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Konfirmasi Transfer'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Dari      : $_selectedRekeningAsal'),
            Text('Ke        : $rekeningTujuan'),
            Text('Jumlah    : Rp $nominal'),
            if (berita.isNotEmpty) Text('Berita    : $berita'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Transfer berhasil diproses')),
              );
            },
            child: Text('Kirim'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transfer Uang'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _selectedRekeningAsal,
              items: _rekeningList
                  .map((rekening) => DropdownMenuItem(
                        value: rekening,
                        child: Text(rekening),
                      ))
                  .toList(),
              decoration: InputDecoration(
                labelText: 'Pilih Rekening Asal',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _selectedRekeningAsal = value;
                });
              },
            ),
            SizedBox(height: 20),
            TextField(
              controller: _nomorRekeningController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Nomor Rekening Tujuan',
                hintText: 'Contoh: 1234567890',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _nominalController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Nominal Transfer',
                hintText: 'Contoh: 250000',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _beritaController,
              decoration: InputDecoration(
                labelText: 'Berita Transfer (Opsional)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: _konfirmasiTransfer,
              icon: Icon(Icons.send),
              label: Text('Konfirmasi Transfer'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
