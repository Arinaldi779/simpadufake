import 'package:flutter/material.dart';
import '../tahun_akademik.dart';
// import '../models/tahun_akademik_model.dart';
import '../services/tahun_akademik_service.dart';

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
            padding: const EdgeInsets.only(
              left: 10.0,
            ), // Menambahkan padding kiri
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
          Center(
            // Membungkus Wrap dengan Center untuk memposisikan tombol di tengah
            child: Wrap(
              spacing: 30, // Mengurangi jarak horizontal
              runSpacing: 13, // Mengurangi jarak vertikal
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const QuickActionCard(
                  iconPath: 'assets/icons/aksiKelas.png',
                  label: 'Buat Daftar Kelas',
                  backgroundColor: Color(0xFFBA7CFF),
                  // iconColor: Color(0xFF6A4271), // Hapus baris ini
                ),
                QuickActionCard(
                  iconPath: 'assets/icons/buatAksi.png',
                  label: 'Buat Tahun Akademik',
                  backgroundColor: Color(0xFF7FAAFF),
                  iconColor: Color(0xFFFFFFFF),
                  onTap: () {
                    _showAddTahunAkademikDialog(context);
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Center(
            // Membungkus Wrap dengan Center untuk memposisikan tombol di tengahchild: Wrap(
            child: Wrap(
              spacing: 30, // Mengurangi jarak horizontal
              runSpacing: 13, // Mengurangi jarak vertikal
              crossAxisAlignment: WrapCrossAlignment.center,
              children: const [
                SizedBox(
                  // Mengatur tinggi tombol
                  child: QuickActionCard(
                    iconPath: 'assets/icons/tambahAksi.png',
                    label: 'Tambah Mahasiswa',
                    backgroundColor: Color(0xFFF8A7E5),
                    iconColor: Colors.white,
                    isSpecial: true,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          const Divider(height: 7, thickness: 10, color: Color.fromARGB(255, 240, 241, 241)),
        ],
      ),
    );
  }
  
  // Method to show the add dialog for Tahun Akademik
  void _showAddTahunAkademikDialog(BuildContext context) {
    final TahunAkademikService _service = TahunAkademikService();
    
    showDialog(
      context: context,
      builder: (context) => AddEditTahunAkademikDialog(
        isEditing: false,
        tahunAkademik: null,
        onSave: (tahunAkademik) async {
          try {
            await _service.addTahunAkademik(tahunAkademik);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Tahun Akademik berhasil ditambahkan!'),
                backgroundColor: Colors.green,
              ),
            );
            
            // Refresh the data if needed
            // This would typically call _loadTahunAkademik() in the TahunAkademikPage
            // Since we're in a different widget, we might need to use a state management solution
            // or navigate back to the TahunAkademikPage to refresh the data
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: $e'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
      ),
    );
  }
}

class QuickActionCard extends StatelessWidget {
  final String iconPath;
  final String label;
  final Color backgroundColor;
  final Color? iconColor;
  final bool isSpecial;
  final VoidCallback? onTap;

  const QuickActionCard({
    super.key,
    required this.iconPath,
    required this.label,
    required this.backgroundColor,
    this.iconColor,
    this.isSpecial = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isSpecial ? 158.14 : 158.14, // Lebih lebar jika special
      height:
          isSpecial
              ? 39.17
              : 39.17, // Lebih tinggi jika special // Mengatur tinggi tombol
      child: ElevatedButton(
        onPressed: onTap ?? () {
          // Default action if onTap is not provided
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          alignment: Alignment.center, // Mengubah alignment menjadi center
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
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
                  overflow:
                      TextOverflow
                          .ellipsis, // Menambahkan titik-titik jika teks terpotong
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
