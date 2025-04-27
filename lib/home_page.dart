import 'package:flutter/material.dart';
import 'package:flutter_application_tugas_pemob2/tarik_tunai.dart';
import 'package:flutter_application_tugas_pemob2/cek_saldo.dart';
import 'package:flutter_application_tugas_pemob2/transfer.dart';
import 'package:flutter_application_tugas_pemob2/deposito.dart';
import 'package:flutter_application_tugas_pemob2/profile.dart';
import 'package:flutter_application_tugas_pemob2/pembayaran.dart';
import 'package:flutter_application_tugas_pemob2/pinjaman.dart';
import 'package:flutter_application_tugas_pemob2/mutasi.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Koperasi Undiksha',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF1E3A8A),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
             
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('saya.jpg'), 
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nasabah',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Putra Bambang Sihombing',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 10),
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.blue[100],
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [Text(
                                    'Total Saldo Anda',
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Rp. 50.000',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                    ],
                                  )
                                  
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

              SizedBox(height: 20),

              // Grid Menu
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 4)),
                  ],
                ),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    _buildMenuItem(Icons.account_balance_wallet, "Cek Saldo", onPressed:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CekSaldoPage()
                       ),
                       );
                    } ),
                    _buildMenuItem(Icons.send, "Transfer" , onPressed: () {
                      Navigator.push(context,  MaterialPageRoute(builder: (context) => TransferPage()
                      ),
                      );
                    },),
                    _buildMenuItem(Icons.savings, "Deposito" ,onPressed: () {
                      Navigator.push(context,  MaterialPageRoute(builder: (context) => DepositoPage()
                      ),
                      );
                    }, ),
                    _buildMenuItem(Icons.credit_card, "Pembayaran" ,onPressed: () {
                      Navigator.push(context,  MaterialPageRoute(builder: (context) => PembayaranPage()
                      ),
                      );
                    },),
                    _buildMenuItem(Icons.business_center, "Pinjaman " ,onPressed: () {
                      Navigator.push(context,  MaterialPageRoute(builder: (context) => PinjamanPage()
                      ),
                      );
                    },),
                    _buildMenuItem(Icons.receipt_long, "Mutasi" , onPressed: () {
                      Navigator.push(context,  MaterialPageRoute(builder: (context) => PinjamanPage()
                      ),
                      );
                    },),
                    _buildMenuItem(Icons.money_off, "Tarik Tunai", onPressed: () 
                    {
                      Navigator.push(context, MaterialPageRoute
                      (
                        builder: (context) => TarikTunai()
                        ),
                        );
                    })
                  ],
                ),
              ),

              SizedBox(height: 20),

            
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Butuh Bantuan?', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                        Text('0858-3173-6145', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Icon(Icons.phone, color: Colors.blue, size: 40),
                  ],
                ),
              ),

              SizedBox(height: 20),

          
Row(
  mainAxisAlignment: MainAxisAlignment.spaceAround,
  children: [
    _buildBottomNavItem(Icons.settings, "Setting", onTap: () {
      // Arahkan ke halaman Setting jika ada
    }),
    _buildBottomNavItem(Icons.qr_code, "", onTap: () {
      // QR code action (jika ada)
    }),
    _buildBottomNavItem(Icons.person, "Profile", onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage()),
      );
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
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 40, color: Colors.blue),
        SizedBox(height: 5),
        Text(label, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    ),
  );
}



  Widget _buildBottomNavItem(IconData icon, String label, {VoidCallback? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        Icon(icon, size: 40, color: Colors.blue),
        if (label.isNotEmpty) SizedBox(height: 5),
        if (label.isNotEmpty)
          Text(label, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    ),
  );
}

}
