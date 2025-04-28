import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
Widget build(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 50.0), // Tambahkan padding top
    child: Column(
      children: [
        Image.asset(
          'assets/images/LogoLoginSignIn.png',
          width: 95,
          height: 95,
        ),
        const SizedBox(height: 10),
        const Text(
          'SIMPADU',
          style: TextStyle(
            fontSize: 33,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
        const Text(
          'Sistem Informasi Terpadu',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            fontFamily: 'Poppins',
          ),
        ),
        const SizedBox(height: 28),
        const Text(
          'Selamat Datang Kembali',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
        const Text(
          'Silahkan masuk ke akun Anda',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontFamily: 'Poppins',
          ),
        ),
      ],
    ),
  );
}
  }
