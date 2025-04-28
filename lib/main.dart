import 'package:flutter/material.dart';
import 'package:simpadu/splash_page.dart';
import 'package:simpadu/login_page.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login', // Ubah rute awal ke halaman login
      routes: {
        '/': (context) => const SplashPage(), // Halaman Splash
        '/login': (context) => const LoginPage(), // Halaman Login
        // '/home': (context) => const HomePage(), // Halaman Home
      },
    );
  }
}