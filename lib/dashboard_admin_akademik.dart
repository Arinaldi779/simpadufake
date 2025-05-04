import 'package:flutter/material.dart';

class DashboardAdmin extends StatelessWidget {
  const DashboardAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // HEADER
            Stack(
              children: [
                // Background Header
                Container(
                  height: 250, // Tinggi header
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF2103FF), // Warna biru terang
                        Color(0xFF140299), // Warna biru gelap
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.0, 0.71], // Posisi gradasi
                    ),
                  ),
                ),
                // Elemen Melengkung di Sisi Kanan Bawah Header
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      // Warna biru terang
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                      ),
                    ),
                  ),
                ),
                // Elemen Melengkung di Bawah Header
                Positioned(
                  bottom: 0,
                  left: 4,
                  right: 4,
                  child: Container(
                    height: 75,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                  ),
                ),
                // Konten Header
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Logo dan Teks
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 5,
                              left: 13,
                            ), // Tambahkan padding kiri
                            child: const CircleAvatar(
                              backgroundImage: AssetImage(
                                'assets/images/LogoDash.png',
                              ),
                              radius: 20, // Ukuran logo
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'SIMPADU',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                      // Ikon Notifikasi
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color:
                              Colors.transparent, // Latar belakang transparan
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.notifications, // Ikon notifikasi
                          color: Color(
                            0xFFFFFF00,
                          ), // Warna kuning sesuai desain
                          size: 30, // Ukuran ikon lebih besar
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
