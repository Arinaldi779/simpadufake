import 'package:flutter/material.dart';
import '../widgets/admin_header.dart';
import '../widgets/admin_profile_card.dart';
import '../widgets/quick_action.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth_helper.dart'; // Pastikan file ini ada dan benar
import '../widgets/important_notifications.dart';

class DashboardAdmin extends StatefulWidget {
  const DashboardAdmin({super.key});

  @override
  State<DashboardAdmin> createState() => _DashboardAdminState();
}

class _DashboardAdminState extends State<DashboardAdmin> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkTokenAndRedirect(context);
  }

  Future<void> _checkTokenAndRedirect(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null || token.isEmpty) {
      // Token tidak ada, arahkan ke halaman login
      logoutAndRedirect(context);
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

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
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: AdminProfileCard(screenWidth: screenWidth),
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