import 'package:flutter/material.dart';
import 'package:simpadu/splash_page.dart';
import 'package:simpadu/login_page.dart'; 
import 'package:simpadu/dashboard_admin_akademik.dart'; // Import halaman Dashboard

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // Rute awal ke halaman 
      routes: {
        '/': (context) => const SplashPage(), // Halaman Splash
        '/login': (context) => const LoginPage(), // Halaman Login
        '/dashboard': (context) => DashboardAdmin(), // Halaman Dashboard Admin Akademik
      }
    );
  }
}