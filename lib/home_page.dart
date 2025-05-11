import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'nasabah_provider.dart';
import 'cekSaldo.dart';
import 'transfer.dart';
import 'deposito.dart';
import 'pembayaran.dart';
import 'pinjaman.dart';
import 'mutasi.dart';
import 'pengaturan.dart';
import 'profile.dart';
import 'qris.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final String namaNasabah = 'Putra Bambang Sihombing';

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
    title: RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'KOPERASI UNDIKSHA',
            style: TextStyle(
              color: Colors.white, 
              fontWeight: FontWeight.bold, 
              fontSize: 18,
            ),
          ),
        ],
      ),
    ),
    backgroundColor: const Color(0xFF0057A6),
    centerTitle: true,
    elevation: 0,
  ),
      body: Column(
        children: [
          // Header Saldo
          Container(
            width: double.infinity,
            color: const Color(0xFF0057A6),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hai, $namaNasabah', style: const TextStyle(color: Colors.white, fontSize: 18)),
                const SizedBox(height: 8),
                const Text('Saldo Anda', style: TextStyle(color: Colors.white70, fontSize: 14)),
                const SizedBox(height: 4),
                Text(formattedSaldo, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  children: [
                    // Grid Menu
                    GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _buildMenuItem(Icons.account_balance_wallet, "Cek Saldo", () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => CekSaldoPage()));
                        }),
                        _buildMenuItem(Icons.send, "Transfer", () async {
                          final result = await Navigator.push(context, MaterialPageRoute(builder: (_) => TransferPage()));
                          if (result == true) setState(() {});
                        }),
                        _buildMenuItem(Icons.savings, "Deposito", () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => DepositoPage()));
                        }),
                        _buildMenuItem(Icons.credit_card, "Pembayaran", () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => PembayaranPage()));
                        }),
                        _buildMenuItem(Icons.business_center, "Pinjaman", () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => PinjamanPage()));
                        }),
                        _buildMenuItem(Icons.receipt_long, "Mutasi", () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => MutasiPage()));
                        }),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Help Section
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF6600),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Butuh Bantuan?', style: TextStyle(color: Colors.white, fontSize: 16)),
                          Text('0858-3173-6145', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF0057A6),
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() => _selectedIndex = index);
          if (index == 0) {
            // stay
          } else if (index == 1) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => QRViewExample()));
          } else if (index == 2) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => ProfilePage()));
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: 'QRIS',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFF0057A6),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 28, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
