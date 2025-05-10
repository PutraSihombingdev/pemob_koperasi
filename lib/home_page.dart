import 'package:aplikasikoperasiundiksha/pengaturan.dart';
import 'package:aplikasikoperasiundiksha/qris.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'cekSaldo.dart';
import 'transfer.dart';
import 'deposito.dart';
import 'profile.dart';
import 'pembayaran.dart';
import 'pinjaman.dart';
import 'mutasi.dart';
import 'nasabah_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String namaNasabah = 'Putra Bambang Sihombing';

  @override
  Widget build(BuildContext context) {
    final saldo = context.watch<NasabahProvider>().saldo;

    final formattedSaldo = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 2,
    ).format(saldo);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Koperasi Undiksha',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF1E3A8A),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Profile Card
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage('pto.jpg'),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Selamat Datang,',
                              style: TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            Text(
                              namaNasabah,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.blue[50],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Total Saldo Anda",
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    formattedSaldo,
                                    style: const TextStyle(fontSize: 18, color: Colors.blue, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Grid Menu
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 4))],
                ),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildMenuItem(Icons.account_balance_wallet, "Cek Saldo", onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CekSaldoPage()));
                    }),
                    _buildMenuItem(Icons.send, "Transfer", onPressed: () async {
                      final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => TransferPage()));
                      if (result == true) {
                        setState(() {});
                      }
                    }),
                    _buildMenuItem(Icons.savings, "Deposito", onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DepositoPage()));
                    }),
                    _buildMenuItem(Icons.credit_card, "Pembayaran", onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PembayaranPage()));
                    }),
                    _buildMenuItem(Icons.business_center, "Pinjaman", onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PinjamanPage()));
                    }),
                    _buildMenuItem(Icons.receipt_long, "Mutasi", onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MutasiPage()));
                    }),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Bantuan
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Butuh Bantuan?', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text('0858-3173-6145', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue)),
                      ],
                    ),
                    Icon(Icons.phone, color: Colors.blue),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Bottom Navigation
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildBottomNavItem(Icons.settings, "Setting", onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
                  }),
                  _buildBottomNavItem(Icons.qr_code, "QRIS", onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => QRViewExample()));
                  }),
                  _buildBottomNavItem(Icons.person, "Profile", onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String label, {VoidCallback? onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 36, color: Colors.blue[700]),
            const SizedBox(height: 8),
            Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavItem(IconData icon, String label, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, size: 32, color: Colors.blue[700]),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
