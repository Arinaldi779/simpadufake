import 'package:flutter/material.dart';
import 'package:simpadu/services/auth.dart';

class DashboardAdminProdi extends StatelessWidget {
  const DashboardAdminProdi({super.key});

  Future<void> _logout(BuildContext context) async {
    await ApiService.logout();
    if (context.mounted) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Admin Prodi'),
        backgroundColor: const Color(0xFF2103FF),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.school, size: 80, color: Color(0xFF2103FF)),
            SizedBox(height: 20),
            Text(
              'Selamat datang di Dashboard Admin Prodi',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'Halaman ini masih dalam pengembangan.',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Poppins',
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}