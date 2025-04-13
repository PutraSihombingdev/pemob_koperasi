import 'package:flutter/material.dart';

class DepositoPage extends StatefulWidget {
  @override
  _DepositoPageState createState() => _DepositoPageState();
}

class _DepositoPageState extends State<DepositoPage> {
  final TextEditingController _nominalController = TextEditingController();
  String? _selectedRekening;
  String? _selectedTenor;

  final List<String> _rekeningList = [
    'Rekening Utama - 1234',
    'Tabungan - 5678',
  ];

  final List<String> _tenorList = [
    '1 Bulan',
    '3 Bulan',
    '6 Bulan',
    '12 Bulan',
  ];

  void _konfirmasiDeposito() {
    final nominal = _nominalController.text.trim();

    if (_selectedRekening == null || _selectedTenor == null || nominal.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Harap isi semua data')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Konfirmasi Deposito'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Rekening Sumber : $_selectedRekening'),
            Text('Nominal         : Rp $nominal'),
            Text('Jangka Waktu    : $_selectedTenor'),
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
                SnackBar(content: Text('Deposito berhasil dibuat')),
              );
            },
            child: Text('Setor Deposito'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buka Deposito'),
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
                labelText: 'Pilih Rekening Sumber',
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
                labelText: 'Nominal Deposito',
                hintText: 'Contoh: 1000000',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedTenor,
              items: _tenorList
                  .map((tenor) => DropdownMenuItem(
                        value: tenor,
                        child: Text(tenor),
                      ))
                  .toList(),
              decoration: InputDecoration(
                labelText: 'Jangka Waktu Deposito',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _selectedTenor = value;
                });
              },
            ),
            SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: _konfirmasiDeposito,
              icon: Icon(Icons.savings),
              label: Text('Konfirmasi Deposito'),
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
