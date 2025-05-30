import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Untuk ukuran responsif
import 'package:responsive_framework/responsive_framework.dart'; // Untuk layout responsif

// Import halaman-halaman aplikasi
import 'package:simpadu/daftar_kelas.dart';
import 'package:simpadu/services/protected_route.dart';
import 'package:simpadu/mahasiswa.dart';
import 'package:simpadu/splash_page.dart';
import 'package:simpadu/login_page.dart';
import 'package:simpadu/dashboard_admin_akademik.dart';
import 'package:simpadu/dashboard_admin_prodi.dart';
import 'package:simpadu/tahun_akademik.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit( // Inisialisasi screenutil
      designSize: const Size(402, 874), // Ukuran desain awal (misal iPhone 11)
      builder: (context, child) => MaterialApp(
        builder: (context, child) => ResponsiveWrapper.builder( // Inisialisasi responsive framework
          child,
          maxWidth: 1200,
          minWidth: 450,
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.resize(450, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(800, name: TABLET),
            const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
          ],
        ),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Poppins',
          // tambahkan custom tema lainnya di sini
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashPage(),
          '/login': (context) => const LoginPage(),
          '/dashboard': (context) => const ProtectedRoute(page: DashboardAdmin()),
          '/dashboard_prodi': (context) => const ProtectedRoute(page: DashboardAdminProdi()),
          '/mahasiswa': (context) => const ProtectedRoute(page: DaftarMahasiswaPage()),
          '/tahunAkademik': (context) => const ProtectedRoute(page: TahunAkademikPage()),
          '/daftarKelas': (context) => const ProtectedRoute(page: DaftarKelasPage()),
        },
      ),
    );
  }
}