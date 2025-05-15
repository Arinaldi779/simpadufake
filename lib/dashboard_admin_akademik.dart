// Halaman utama Dashboard Admin
// Menampilkan layout dengan header, statistik, aksi cepat, dan notifikasi penting

import 'package:flutter/material.dart';
import '../widgets/admin_header.dart';
import '../widgets/admin_profile_card.dart';
import '../widgets/quick_action.dart';
import '../widgets/important_notifications.dart';

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
              offset: const Offset(0, -180),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 15),
                child: AdminProfileCard(
                  screenWidth: screenWidth,
                ),
              ),
            ),

            // Aksi Cepat
            Transform.translate(
              offset: const Offset(0, -155),
              child: const QuickActions(),
            ),
            const SizedBox(height: 10),

            // Notifikasi Penting
            Transform.translate(
              offset: const Offset(0, -105),
              child: const ImportantNotifications(),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
