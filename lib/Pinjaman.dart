import 'package:aplikasikoperasiundiksha/mutasi_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'nasabah_provider.dart';
import 'pinjaman_provider.dart';

class PinjamanPage extends StatelessWidget {
  const PinjamanPage({super.key});

  void _showDialog(BuildContext context, String message) {
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
  void _bayarPinjaman(
  BuildContext context,
  Pinjaman pinjaman,
  double jumlah,
) {
  final saldoProvider = context.read<NasabahProvider>();
  final pinjamanProvider = context.read<PinjamanProvider>();
  final mutasiProvider = context.read<MutasiProvider>();

  if (jumlah <= 0) {
    _showDialog(context, 'Jumlah pembayaran tidak valid.');
    return;
  }

  if (jumlah > saldoProvider.saldo) {
    _showDialog(context, 'Saldo tidak cukup untuk membayar.');
    return;
  }

  saldoProvider.updateSaldo(saldoProvider.saldo - jumlah);
  pinjamanProvider.bayarPinjaman(pinjaman.nomorRekening, jumlah);

  mutasiProvider.tambahMutasi(Mutasi(
    tipe: 'Pembayaran Pinjaman',
    deskripsi: 'Pembayaran ke rekening ${pinjaman.nomorRekening}',
    jumlah: jumlah,
    tanggal: DateTime.now(),
  ));

  _showDialog(
    context,
    'Pembayaran berhasil: Rp ${NumberFormat("#,##0", "id_ID").format(jumlah)}',
  );
}



  @override
  Widget build(BuildContext context) {
    final saldo = context.watch<NasabahProvider>().saldo;
    final pinjamanList = context.watch<PinjamanProvider>().pinjamanList;

    final formattedSaldo = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 2).format(saldo);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pembayaran Pinjaman', style: TextStyle(
        color: Colors.white, 
        fontSize: 20,
        fontWeight: FontWeight.bold, 
      ),),
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Saldo Saat Ini: $formattedSaldo', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: pinjamanList.length,
                itemBuilder: (context, index) {
                  final pinjaman = pinjamanList[index];
                  final formattedSisa = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 2).format(pinjaman.sisaPokok);
                  final controller = TextEditingController();

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          
                          Text('Jenis Pinjaman: ${pinjaman.jenisPinjaman}'),
                          Text('Sisa Pokok: $formattedSisa'),
                          const SizedBox(height: 10),
                          TextField(
                            controller: controller,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Jumlah Bayar',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              final jumlah = double.tryParse(controller.text.replaceAll(',', '').replaceAll('.', '')) ?? 0;
                              _bayarPinjaman(context, pinjaman, jumlah);
                            },
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[700]),
                            child: const Text('Bayar Pinjaman',style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
