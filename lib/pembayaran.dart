import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'nasabah_provider.dart';
import 'mutasi_provider.dart'; 

class PembayaranPage extends StatefulWidget {
  const PembayaranPage({super.key});

  @override
  State<PembayaranPage> createState() => _PembayaranPageState();
}

class _PembayaranPageState extends State<PembayaranPage> {
  final _nomorAnggotaController = TextEditingController();
  final _jumlahBayarController = TextEditingController();

  String _jenisPembayaran = 'Setoran Simpanan';
  String _metodePembayaran = 'Transfer Bank';

  void _prosesPembayaran(BuildContext context) {
    final nomorAnggota = _nomorAnggotaController.text.trim();
    final jumlah = double.tryParse(_jumlahBayarController.text.replaceAll(',', '').replaceAll('.', '')) ?? 0;

    if (nomorAnggota.isEmpty || jumlah <= 0) {
      _showDialog('Nomor anggota atau jumlah pembayaran tidak valid.');
      return;
    }

    final formattedJumlah = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 2,
    ).format(jumlah);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Konfirmasi Pembayaran'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nomor Anggota: $nomorAnggota'),
            Text('Jenis Pembayaran: $_jenisPembayaran'),
            Text('Metode Pembayaran: $_metodePembayaran'),
            const SizedBox(height: 8),
            Text('Jumlah: $formattedJumlah', style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: () {
              final saldo = context.read<NasabahProvider>().saldo;
                final mutasiProvider = context.read<MutasiProvider>();
                
                mutasiProvider.tambahMutasi(Mutasi(
                tipe: 'Pembayaran',
                deskripsi: '$_jenisPembayaran via $_metodePembayaran',
                jumlah: -jumlah, 
                tanggal: DateTime.now(),
              ));
              context.read<NasabahProvider>().updateSaldo(saldo - jumlah);
              Navigator.pop(context); // tutup dialog
              _showDialog('Pembayaran $_jenisPembayaran sebesar $formattedJumlah berhasil diproses.');
              _nomorAnggotaController.clear();
              _jumlahBayarController.clear();
            },
            child: const Text('Konfirmasi'),
          ),
        ],
      ),
    );
    
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Informasi'),
        content: Text(message),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final saldo = context.watch<NasabahProvider>().saldo;
    final formattedSaldo = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 2).format(saldo);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Pembayaran Koperasi'),
        backgroundColor: Colors.indigo[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Saldo Anda Saat Ini: $formattedSaldo',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              TextField(
                controller: _nomorAnggotaController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Nomor Anggota',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _jenisPembayaran,
                items: const [
                  DropdownMenuItem(value: 'Setoran Simpanan', child: Text('Setoran Simpanan')),
                  DropdownMenuItem(value: 'Pembayaran Barang Online', child: Text('Pembayaran Barang Online')),
                  DropdownMenuItem(value: 'Pembelian Pulsa/Token', child: Text('Pembelian Pulsa/Token')),
                ],
                onChanged: (value) {
                  setState(() {
                    _jenisPembayaran = value!;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Jenis Pembayaran',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _jumlahBayarController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Jumlah Pembayaran',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _metodePembayaran,
                items: const [
                  DropdownMenuItem(value: 'Transfer Bank', child: Text('Transfer Bank')),
                  DropdownMenuItem(value: 'Tunai', child: Text('Tunai')),
                  DropdownMenuItem(value: 'Virtual Account', child: Text('Virtual Account')),
                ],
                onChanged: (value) {
                  setState(() {
                    _metodePembayaran = value!;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Metode Pembayaran',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _prosesPembayaran(context),
                  icon: const Icon(Icons.payment),
                  label: const Text('Bayar Sekarang'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo[700],
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
