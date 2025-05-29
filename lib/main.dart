import 'package:flutter/material.dart';
import 'package:simpadu/daftar_kelas.dart';
import 'package:simpadu/services/protected_route.dart';
import 'package:simpadu/mahasiswa.dart';
import 'package:simpadu/splash_page.dart';
import 'package:simpadu/login_page.dart';
import 'package:simpadu/dashboard_admin_akademik.dart'; // Import halaman Dashboard
import 'package:simpadu/dashboard_admin_prodi.dart';
import 'package:simpadu/tahun_akademik.dart'; // Import halaman Dashboard

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
         // Halaman Dashboard Admin Akademik
        '/dashboard': (context) => const ProtectedRoute(page: DashboardAdmin()),
        '/dashboard_prodi':
            (context) => const ProtectedRoute(page: DashboardAdminProdi()),
        '/mahasiswa':
            (context) => const ProtectedRoute(page: DaftarMahasiswaPage()),
        '/tahunAkademik':
            (context) => const ProtectedRoute(page: TahunAkademikPage()),
        '/daftarKelas':
            (context) => const ProtectedRoute(
              page: DaftarKelasPage(),
            ), // Halaman Dashboard Admin Akademik
      },
    );
  }
}
