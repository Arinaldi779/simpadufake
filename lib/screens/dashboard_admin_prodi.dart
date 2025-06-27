// dashboard_admin_prodi.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import '../../widgets/admin_header.dart';
import '../../widgets/admin_profile_card_prodi.dart';
import '../../widgets/quick_actions_prodi.dart';
import '../../widgets/important_notifications_prodi.dart';
import '../../services/auth_helper.dart';
import '../../services/auth_middleware.dart';

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
    _checkAuthAndRedirect();
  }

  Future<void> _checkAuthAndRedirect() async {
    final valid = await isTokenValid();
    if (!valid && mounted) {
      handleUnauthorized(context);
    } else {
      await Future.delayed(const Duration(microseconds: 100));
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _exitApp() {
    SystemNavigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            brightness == Brightness.dark ? Brightness.light : Brightness.dark,
        statusBarBrightness: brightness,
      ),
    );
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          clipBehavior: Clip.hardEdge,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AdminHeader(),
              SizedBox(height: 10.h),
              Transform.translate(
                offset: Offset(0, -180.h),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.h,
                    horizontal: 15.w,
                  ),
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
              // Contoh pemakaian:
              ElevatedButton(
                onPressed: _exitApp,
                child: Text('Keluar Aplikasi'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
