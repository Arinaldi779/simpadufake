import 'package:flutter/material.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      '2025 SIMPADU - Politeknik Negeri Banjarmasin',
      style: TextStyle(
        fontSize: 12,
        color: Colors.grey,
        fontFamily: 'Poppins',
      ),
    );
  }
}