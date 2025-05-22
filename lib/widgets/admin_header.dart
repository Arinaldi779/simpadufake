// Widget header halaman admin dengan gradient biru dan logo

import 'package:flutter/material.dart';
import 'package:simpadu/services/auth.dart';

class AdminHeader extends StatelessWidget {
  const AdminHeader({super.key});

  Future<void> _logout(BuildContext context) async {
    await ApiService.logout();
    if (context.mounted) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background gradient
        Container(
          height: 250,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2103FF), Color(0xFF140299)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, 0.71],
            ),
          ),
        ),
        // Latar putih di bawah header
        Positioned(
          bottom: 0,
          left: 4,
          right: 4,
          child: Container(
            height: 75,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
          ),
        ),
        // Logo dan notifikasi
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(top: 5, left: 13),
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/LogoDash.png'),
                      radius: 20,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'SIMPADU',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.notifications,
                      color: Color(0xFFFFFF00),
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.logout, color: Colors.white),
                    tooltip: 'Logout',
                    onPressed: () => _logout(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
