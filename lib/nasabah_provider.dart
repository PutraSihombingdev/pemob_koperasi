import 'package:flutter/foundation.dart';

class NasabahProvider extends ChangeNotifier {
  String nama = 'Putra Bambang Sihombing';
  double saldo = 5000000;

  void updateSaldo(double baru) {
    saldo = baru;
    notifyListeners();
  }
}
