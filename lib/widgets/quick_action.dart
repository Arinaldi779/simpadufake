import 'package:flutter/material.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0), // Menambahkan padding kiri
            child: const Text(
              'Aksi Cepat',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          const SizedBox(height: 12),
          Center( // Membungkus Wrap dengan Center untuk memposisikan tombol di tengah
            child: Wrap(
              spacing: 20, // Mengurangi jarak horizontal
              runSpacing: 13, // Mengurangi jarak vertikal
              crossAxisAlignment: WrapCrossAlignment.center,
              children: const [
                QuickActionCard(
                  iconPath: 'assets/icons/aksiKelas.png',
                  label: 'Buat Daftar Kelas',
                  backgroundColor: Color(0xFFBA7CFF),
                  // iconColor: Color(0xFF6A4271), // Hapus baris ini
                ),
                QuickActionCard(
                  iconPath: 'assets/icons/editAksi.png',
                  label: 'Edit Mahasiswa',
                  backgroundColor: Color(0xFF88D980),
                  iconColor: Colors.white,
                ),
                QuickActionCard(
                  iconPath: 'assets/icons/buatAksi.png',
                  label: 'Buat Tahun Akademik',
                  backgroundColor: Color(0xFF7FAAFF),
                  iconColor: Colors.white,
                ),
                QuickActionCard(
                  iconPath: 'assets/icons/tambahAksi.png',
                  label: 'Tambah Mahasiswa',
                  backgroundColor: Color(0xFFF8A7E5),
                  iconColor: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class QuickActionCard extends StatelessWidget {
  final String iconPath;
  final String label;
  final Color backgroundColor;
  final Color? iconColor;

  const QuickActionCard({
    super.key,
    required this.iconPath,
    required this.label,
    required this.backgroundColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 158.14, // Mengatur lebar tombol
      height: 39.17, // Mengatur tinggi tombol
      child: ElevatedButton(
        onPressed: () {
          // TODO: Tambahkan aksi navigasi
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          alignment: Alignment.center, // Mengubah alignment menjadi center
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          elevation: 6,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              iconPath,
              width: 22,
              height: 22,
              color: iconColor, // Tetap gunakan iconColor jika ada
            ),
            Expanded(
              child: Center(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                  maxLines: 1, // Membatasi teks menjadi satu baris
                  overflow: TextOverflow.ellipsis, // Menambahkan titik-titik jika teks terpotong
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}