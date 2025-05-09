import 'package:flutter/material.dart';

class Pinjaman {
  String nomorRekening;
  String jenisPinjaman;
  double plafond;
  double sisaPokok;
  String tanggalJatuhTempo;

  Pinjaman({
    required this.nomorRekening,
    required this.jenisPinjaman,
    required this.plafond,
    required this.sisaPokok,
    required this.tanggalJatuhTempo,
  });
}

class PinjamanProvider extends ChangeNotifier {
  double _saldoPengguna = 10000000; // saldo awal pengguna misalnya 10 juta

  List<Pinjaman> _pinjamanList = [
    Pinjaman(
      nomorRekening: '00123456789',
      jenisPinjaman: 'Kredit Motor',
      plafond: 15000000,
      sisaPokok: 8000000,
      tanggalJatuhTempo: '2025-12-31',
    ),
    Pinjaman(
      nomorRekening: '00987654321',
      jenisPinjaman: 'Kredit Rumah',
      plafond: 500000000,
      sisaPokok: 350000000,
      tanggalJatuhTempo: '2030-06-30',
    ),
  ];

  double get saldoPengguna => _saldoPengguna;
  List<Pinjaman> get pinjamanList => _pinjamanList;

  void bayarPinjaman(String nomorRekening, double jumlah) {
    final index = _pinjamanList.indexWhere((p) => p.nomorRekening == nomorRekening);
    if (index != -1 && jumlah > 0 && jumlah <= _saldoPengguna) {
      // Kurangi saldo
      _saldoPengguna -= jumlah;

      // Kurangi sisa pokok pinjaman
      _pinjamanList[index].sisaPokok -= jumlah;
      if (_pinjamanList[index].sisaPokok < 0) {
        _pinjamanList[index].sisaPokok = 0;
      }

      notifyListeners();
    }
  }
}
