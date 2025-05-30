import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          height: 250.h,
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
          left: 0,
          right: 0,
          child: Container(
            height: 75.h,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
          ),
        ),
        // Logo dan notifikasi
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 5.h, left: 13.w),
                    child: CircleAvatar(
                      backgroundImage: const AssetImage('assets/images/LogoDash.png'),
                      radius: 20.r,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'SIMPADU',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.w),
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
                  SizedBox(width: 8.w),
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