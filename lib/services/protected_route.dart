// lib/protected_route.dart

import 'package:flutter/material.dart';
import 'package:simpadu/login_page.dart';
import 'auth_middleware.dart';

class ProtectedRoute extends StatelessWidget {
  final Widget page;

  const ProtectedRoute({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isTokenValid(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasData && snapshot.data!) {
          return page; // Tampilkan halaman jika token valid
        } else {
          return const LoginPage(); // Arahkan ke login jika token tidak ada
        }
      },
    );
  }
}