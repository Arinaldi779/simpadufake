import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
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
            colors: [
              Color(0xFF006AFF),
              Color(0xFFFF9C9C),
              Color(0xFFFFF5CF),
            ],
            stops: [0.0, 0.7, 1.0],
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.30), // 25% dari tinggi layar
            Image.asset(
              'assets/images/LogoSplash.png',
              width: 100,
            ),
            const SizedBox(height: 20),
            const Text(
              'SIMPADU\nPOLIBAN',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
