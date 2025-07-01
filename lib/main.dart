import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Untuk ukuran responsif
import 'package:responsive_framework/responsive_framework.dart'; // Untuk layout responsif

// Import halaman-halaman aplikasi
import 'package:simpadu/screens/daftar_kelas.dart';
import 'package:simpadu/services/protected_route.dart';
import 'package:simpadu/screens/mahasiswa.dart';
import 'package:simpadu/screens/splash_page.dart';
import 'package:simpadu/screens/login_page.dart';
import 'package:simpadu/screens/dashboard_admin_akademik.dart';
import 'package:simpadu/screens/dashboard_admin_prodi.dart';
import 'package:simpadu/screens/tahun_akademik.dart';
import 'package:simpadu/screens/kurikulum.dart';
import 'package:simpadu/screens/matakuliah.dart';
import 'package:simpadu/screens/dosen_ajar.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // Inisialisasi screenutil
      designSize: const Size(402, 874), // Ukuran desain awal (misal iPhone 11)
      builder:
          (context, child) => MaterialApp(
            builder:
                (context, child) => ResponsiveWrapper.builder(
                  // Inisialisasi responsive framework
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
              '/': (context) => SplashPage(),
              '/login': (context) => LoginPage(),
              '/dashboard': (context) => ProtectedRoute(page: DashboardAdmin()),
              '/dashboard_prodi':
                  (context) => ProtectedRoute(page: DashboardAdminProdi()),
              '/mahasiswa':
                  (context) => ProtectedRoute(page: DaftarMasiswaPage()),
              '/tahunAkademik':
                  (context) => ProtectedRoute(page: TahunAkademikPage()),
              '/daftarKelas':
                  (context) => ProtectedRoute(page: DaftarKelasPage()),
              '/kurikulum':
                  (context) => ProtectedRoute(page: DaftarKurikulumPage()),
              '/matakuliah':
                  (context) => ProtectedRoute(page: DaftarMataKuliahPage()),
              '/dosenAjar':
                  (context) => ProtectedRoute(page: DaftarDosenAjarPage()),
            },
          ),
    );
  }
}
