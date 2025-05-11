// Halaman utama Dashboard Admin
// Menampilkan layout dengan header dan konten statistik admin

import 'package:flutter/material.dart';
import '../widgets/admin_header.dart';
import '../widgets/admin_profile_card.dart';
import '../widgets/quick_action.dart';

class DashboardAdmin extends StatelessWidget {
  const DashboardAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: SingleChildScrollView(
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AdminHeader(), // Bagian atas halaman
            const SizedBox(height: 5),
            Transform.translate(
              offset: const Offset(0, -180), // Mengangkat konten ke atas
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                child: AdminProfileCard(
                  screenWidth: screenWidth,
                ), // Konten utama
              ),
            ),
            const SizedBox(height: 0), // Ubah dari 5 ke 0 atau hapus jika perlu
            Transform.translate(
              offset: const Offset(0, -160), // Mengangkat Aksi Cepat ke atas
              child: const QuickActions(), // ← Ini bagian Aksi Cepat
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}