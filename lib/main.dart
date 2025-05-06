import 'package:flutter/material.dart';
import 'mutasi.dart';
import 'pembayaran.dart';
import 'profile.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';
import 'home_page.dart';
import 'cekSaldo.dart';
import 'transfer.dart';
import 'deposito.dart';
import 'nasabah_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('is_logged_in') ?? false;

  runApp(
    ChangeNotifierProvider(
      create: (_) => NasabahProvider(),
      child: MyApp(isLoggedIn: isLoggedIn),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? const HomePage() : const LoginPage(),
      routes: {
        '/login': (_) => const LoginPage(),
        '/cek_saldo': (_) => const CekSaldoPage(),
        '/transfer': (_) => const TransferPage(),
        '/deposito': (_) => const DepositoPage(),
        '/pembayaran': (_) => const PembayaranPage(),
        '/mutasi': (_) => const MutasiPage(),
        '/profile': (_) => const ProfilePage(),
      },
    );
  }
}
