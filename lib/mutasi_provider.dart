import 'package:flutter/material.dart';

class Mutasi {
  String tipe; // contoh: 'Pembayaran', 'Transfer', 'Deposito', 'Pinjaman'
  String deskripsi;
  double jumlah;
  DateTime tanggal;

  Mutasi({
    required this.tipe,
    required this.deskripsi,
    required this.jumlah,
    required this.tanggal,
  });
}

class MutasiProvider extends ChangeNotifier {
  final List<Mutasi> _mutasiList = [];

  List<Mutasi> get mutasiList => List.unmodifiable(_mutasiList);

  void tambahMutasi(Mutasi mutasi) {
    _mutasiList.insert(0, mutasi); // tambahkan ke awal agar yang terbaru di atas
    notifyListeners();
  }
}
