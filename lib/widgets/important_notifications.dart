import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ImportantNotifications extends StatelessWidget {
  const ImportantNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32), // Menambahkan padding kiri dan kanan
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Judul + Tombol
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Notifikasi Penting',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Poppins', // Menambahkan fontFamily Poppins
                ),
              ),
              
                TextButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xFF1D03DC),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    minimumSize: const Size(80, 30), // Menetapkan ukuran minimum tombol
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // Menambahkan border radius
                    ),
                  ),
                  onPressed: () {
                    // Aksi saat tombol ditekan
                  },
                  label: Row(
                    children: const [
                      Text(
                        "Selengkapnya",
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w600, // Ubah ukuran font sesuai kebutuhan
                          fontFamily: 'Poppins', // Menambahkan fontFamily Poppins
                        ),
                      ),
                      SizedBox(width: 4), // Menambahkan jarak antara teks dan ikon
                      Icon(Icons.arrow_forward, size: 14),
                    ],
                  ),
                ),
              
            ],
          ),
          const SizedBox(height: 10),

          // Notifikasi 1
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(12),
            constraints: const BoxConstraints(
              minWidth: 300, // Sesuaikan lebar minimum sesuai kebutuhan
              minHeight: 30, // Sesuaikan tinggi minimum sesuai kebutuhan
            ),
            decoration: BoxDecoration(
              color: Colors.red.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Image.asset(
                  'assets/icons/warning.png', // Ganti dengan path gambar Anda
                  width: 24, // Sesuaikan ukuran gambar
                  height: 24,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Belum input nilai untuk 5 kelas",
                    style: TextStyle(
                      fontSize: 10,
                      color: Color(0xFFBB271A),
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins', // Menambahkan fontFamily Poppins
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Notifikasi 2
          Container(
            padding: const EdgeInsets.all(12),
            constraints: const BoxConstraints(
              minWidth: 300, // Sesuaikan lebar minimum sesuai kebutuhan
              minHeight: 30, // Sesuaikan tinggi minimum sesuai kebutuhan
            ),
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Image.asset(
                  'assets/icons/info.png', // Ganti dengan path gambar Anda
                  width: 24, // Sesuaikan ukuran gambar
                  height: 24,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "12 Mahasiswa belum melakukan KRS",
                    style: TextStyle(
                      fontSize: 10,
                      color: Color(0xFF4E84C1),
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins', // Menambahkan fontFamily Poppins
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}