// dashboard_admin_prodi.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/admin_header.dart';
import '../widgets/admin_profile_card_prodi.dart';
import '../widgets/quick_actions_prodi.dart';
import '../widgets/important_notifications_prodi.dart';
import '../services/auth_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardAdminProdi extends StatefulWidget {
  const DashboardAdminProdi({super.key});

  @override
  State<DashboardAdminProdi> createState() => _DashboardAdminProdiState();
}

class _DashboardAdminProdiState extends State<DashboardAdminProdi> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkTokenAndRedirect(context);
  }

  Future<void> _checkTokenAndRedirect(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null || token.isEmpty) {
      // Token tidak ada → handle unauthorized
      handleUnauthorized(context);
    } else {
      // Simulasi delay UI (opsional)
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AdminHeader(),
            SizedBox(height: 10.h),
            Transform.translate(
              offset: Offset(0, -180.h),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                child: AdminProfileCardProdi(screenWidth: screenWidth),
              ),
            ),
            Transform.translate(
              offset: Offset(0, -155.h),
              child: const QuickActionsProdi(),
            ),
            SizedBox(height: 10.h),
            Transform.translate(
              offset: Offset(0, -105.h),
              child: const ImportantNotificationsProdi(),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}

