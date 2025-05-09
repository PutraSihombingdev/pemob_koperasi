import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'mutasi_provider.dart';

class MutasiPage extends StatelessWidget {
  const MutasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mutasiList = context.watch<MutasiProvider>().mutasiList;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mutasi Transaksi'),
        backgroundColor: Colors.blue[900],
      ),
      body: mutasiList.isEmpty
          ? const Center(child: Text('Belum ada transaksi.'))
          : ListView.builder(
              itemCount: mutasiList.length,
              itemBuilder: (context, index) {
                final mutasi = mutasiList[index];
                final formattedJumlah = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 2).format(mutasi.jumlah);
                final formattedTanggal = DateFormat('dd MMM yyyy HH:mm').format(mutasi.tanggal);

                return ListTile(
                  leading: Icon(_getIconForType(mutasi.tipe)),
                  title: Text(mutasi.tipe),
                  subtitle: Text('${mutasi.deskripsi}\n$formattedTanggal'),
                  trailing: Text(formattedJumlah, style: const TextStyle(fontWeight: FontWeight.bold)),
                  isThreeLine: true,
                );
              },
            ),
    );
  }

  IconData _getIconForType(String tipe) {
    switch (tipe) {
      case 'Pembayaran Pinjaman':
        return Icons.payments;
      case 'Deposito':
        return Icons.savings;
      case 'Transfer':
        return Icons.send;
      case 'Pinjaman':
        return Icons.account_balance;
      default:
        return Icons.receipt_long;
    }
  }
}
