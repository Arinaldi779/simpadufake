import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      _checkLoginStatus();
    });
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final role = prefs.getString('role');
    final lastDashboard = prefs.getString('last_dashboard');

    if (!mounted) return;
    if (token != null && token.isNotEmpty) {
      if (role == "Admin Prodi") {
        Navigator.pushReplacementNamed(context, '/dashboard_prodi');
      } else if (role == "Super Admin") {
        if (lastDashboard == 'dashboard_prodi') {
          Navigator.pushReplacementNamed(context, '/dashboard_prodi');
        } else {
          Navigator.pushReplacementNamed(context, '/dashboard');
        }
      } else if (role == "Admin Akademik") {
        Navigator.pushReplacementNamed(context, '/dashboard');
      }
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF006AFF), Color(0xFFFF9C9C), Color(0xFFFFF5CF)],
            stops: [0.0, 0.7, 1.0],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/LogoSplash.png', width: 100),
              const SizedBox(height: 5),
              const Text(
                'SIMPADU\nPOLIBAN',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
