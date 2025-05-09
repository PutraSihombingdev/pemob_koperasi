import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart'; // Import for QR code scanner
import 'nasabah_provider.dart';
import 'mutasi_provider.dart';

class QRISPage extends StatefulWidget {
  const QRISPage({super.key});

  @override
  State<QRISPage> createState() => _QRISPageState();
}

class _QRISPageState extends State<QRISPage> {
  bool _scanned = false; // Flag to avoid multiple triggers
  late QRViewController controller;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _prosesPembayaran(String data) {
    final nasabahProvider = context.read<NasabahProvider>();
    final saldo = nasabahProvider.saldo;
    final nominal = 50000; // Example fixed nominal or can be parsed from data

    if (saldo >= nominal) {
      nasabahProvider.updateSaldo(saldo - nominal); // Decrease balance
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pembayaran berhasil ke $data sebesar Rp $nominal')),
      );
      Navigator.pop(context); // Go back to the previous screen
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Saldo tidak mencukupi untuk pembayaran')),
      );
    }
  }

  void _tampilkanDialogHasil(String data) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('QRIS Terdeteksi'),
        content: Text('Anda akan membayar ke: $data'),
        actions: [
          TextButton(
            onPressed: () {
              _scanned = false; // Reset to scan again
              Navigator.pop(context);
            },
            child: const Text('Scan Lagi'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _prosesPembayaran(data);
            },
            child: const Text('Bayar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pembayaran QRIS'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Stack(
        children: [
          QRView(
            key: UniqueKey(), // Use UniqueKey instead of GlobalKey
            onQRViewCreated: (QRViewController qrController) {
              controller = qrController; // Assign the controller to access further actions
              controller.scannedDataStream.listen((scanData) {
                if (!_scanned) {
                  _scanned = true;
                  final String? code = scanData.code;
                  if (code != null) {
                    _tampilkanDialogHasil(code);
                  }
                }
              });
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.black54,
              padding: const EdgeInsets.all(16),
              child: const Text(
                'Arahkan kamera ke QRIS untuk membayar',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
