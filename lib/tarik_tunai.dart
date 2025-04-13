import 'package:flutter/material.dart';

class TarikTunai extends StatefulWidget {
  @override
  _TarikTunaiPageState createState() => _TarikTunaiPageState();
}

class _TarikTunaiPageState extends State<TarikTunai> {
  final TextEditingController _nominalController = TextEditingController();
  String? _selectedRekening;
  final List<String> _rekeningList = ['Rekening Utama - 1234', 'Tabungan - 5678'];

  void _konfirmasiTarikTunai() {
    final nominal = _nominalController.text;
    if (_selectedRekening == null || nominal.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Harap isi semua data')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Konfirmasi Tarik Tunai'),
        content: Text('Tarik Rp $nominal dari $_selectedRekening?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Permintaan tarik tunai berhasil dikirim')),
              );
            },
            child: Text('Ya, Tarik'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tarik Tunai'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _selectedRekening,
              items: _rekeningList
                  .map((rekening) => DropdownMenuItem(
                        value: rekening,
                        child: Text(rekening),
                      ))
                  .toList(),
              decoration: InputDecoration(
                labelText: 'Pilih Rekening',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _selectedRekening = value;
                });
              },
            ),
            SizedBox(height: 20),
            TextField(
              controller: _nominalController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Nominal Tarik Tunai',
                hintText: 'Contoh: 500000',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: _konfirmasiTarikTunai,
              icon: Icon(Icons.money),
              label: Text('Konfirmasi Tarik Tunai'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50),
              ),
            )
          ],
        ),
      ),
    );
  }
}
