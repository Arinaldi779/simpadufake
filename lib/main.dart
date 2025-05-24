import 'package:flutter/material.dart';
import 'package:simpadu/splash_page.dart';
import 'package:simpadu/login_page.dart';
import 'package:simpadu/dashboard_admin_akademik.dart'; // Import halaman Dashboard
import 'package:simpadu/dashboard_admin_prodi.dart'; // Import halaman Dashboard

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Poppins',
        // ... theme lainnya
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // Rute awal ke halaman
      routes: {
        '/': (context) => const SplashPage(), // Halaman Splash
        '/login': (context) => const LoginPage(), // Halaman Login
        '/dashboard':
            (context) =>
                const DashboardAdmin(), // Halaman Dashboard Admin Akademik
        '/dashboard_prodi':
            (context) =>
                const DashboardAdminProdi(), // Halaman Dashboard Admin Akademik
      },
    );
  }
}
