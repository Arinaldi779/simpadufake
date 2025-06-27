import 'package:flutter/material.dart';
import 'package:simpadu/screens/login_page.dart';
import 'package:quickalert/quickalert.dart';
import 'auth_middleware.dart';

class ProtectedRoute extends StatelessWidget {
  final Widget page;

  const ProtectedRoute({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isTokenValid(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasData && snapshot.data == true) {
          return page;
        } else {
          // Tampilkan alert dan hapus semua stack sebelum pindah ke login
          WidgetsBinding.instance.addPostFrameCallback((_) {
            QuickAlert.show(
              context: context,
              type: QuickAlertType.warning,
              title: 'Sesi Berakhir',
              text: 'Token tidak valid. Silakan login kembali.',
              confirmBtnText: 'Login Ulang',
              onConfirmBtnTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                  (route) => false, // Hapus semua route sebelumnya
                );
              },
            );
          });

          // Kembalikan Scaffold kosong agar tidak error
          return const Scaffold(
            body: Center(),
          );
        }
      },
    );
  }
}