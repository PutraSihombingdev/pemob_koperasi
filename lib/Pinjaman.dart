import 'package:flutter/material.dart';

class PinjamanPage extends StatefulWidget {
  @override
  _PinjamanPageState createState() => _PinjamanPageState();
}

class _PinjamanPageState extends State<PinjamanPage> {
  final TextEditingController _jumlahController = TextEditingController();
  final TextEditingController _alasanController = TextEditingController();
  int _jangkaWaktu = 6;

  void _ajukanPinjaman() {
    final jumlah = _jumlahController.text;
    final alasan = _alasanController.text;

    if (jumlah.isEmpty || alasan.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Semua kolom wajib diisi')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Konfirmasi Pengajuan'),
        content: Text(
          'Ajukan pinjaman sebesar Rp $jumlah dengan jangka waktu $_jangkaWaktu bulan?',
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
                SnackBar(content: Text('Pengajuan pinjaman berhasil dikirim')),
              );
              _jumlahController.clear();
              _alasanController.clear();
              setState(() {
                _jangkaWaktu = 6;
              });
            },
            child: Text('Ajukan'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengajuan Pinjaman'),
        backgroundColor: Colors.indigo[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _jumlahController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Jumlah Pinjaman',
                hintText: 'Contoh: 5000000',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text('Jangka Waktu: ',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                DropdownButton<int>(
                  value: _jangkaWaktu,
                  items: [6, 12, 18, 24]
                      .map((bulan) => DropdownMenuItem(
                            value: bulan,
                            child: Text('$bulan bulan'),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _jangkaWaktu = value!;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            TextField(
              controller: _alasanController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Alasan Pinjaman',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: _ajukanPinjaman,
              icon: Icon(Icons.send),
              label: Text('Ajukan Pinjaman'),
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
