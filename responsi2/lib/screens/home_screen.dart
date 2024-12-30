import 'package:flutter/material.dart';
import 'package:responsi2/screens/login_screen.dart';
import 'package:responsi2/widgets/listview.dart';
import 'package:responsi2/widgets/jemputsampah.dart';
import 'package:responsi2/widgets/saldoriwayat.dart';

void main() => runApp(const WasteManagementApp());

class WasteManagementApp extends StatelessWidget {
  const WasteManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              HeaderSection(),
              SizedBox(height: 20),
              PromoSection(),
              SizedBox(height: 20),
              MenuSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 0, 191, 165),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Selamat Datang",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              IconButton(
                icon: const Icon(Icons.logout, color: Colors.white),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                     (Route<dynamic> route) => false,
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 5),
          const Text(
            "Kisan RA",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.white),
              const SizedBox(width: 5),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "Lokasi Anda",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PromoSection extends StatelessWidget {
  const PromoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset('assets/images/recycle.png', height: 100, width: 100),
            const SizedBox(width: 20),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Tukarkan sampah plastikmu sekarang!",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Aplikasi Bank Sampah adalah solusi untuk menyelesaikan masalah kebersihan lingkungan.",
                    style: TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuSection extends StatelessWidget {
  const MenuSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Menu Kategori",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          GridView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.2,
            ),
            children: [
              _buildMenuCard(
                context,
                Icons.local_shipping,
                "Jemput Sampah",
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const JemputSampahPage()),
                  );
                },
              ),
              _buildMenuCard(
                context,
                Icons.delete_outline,
                "Jenis Sampah",
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const JenisSampahList()),
                  );
                },
              ),
              _buildMenuCard(
                context,
                Icons.account_balance_wallet,
                "Saldo & Riwayat",
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SaldoRiwayatPage()),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.teal),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
