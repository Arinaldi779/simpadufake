import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/admin_header.dart';
import '../widgets/admin_profile_card.dart';
import 'package:quickalert/quickalert.dart';
import '../widgets/quick_action.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth_helper.dart';
import '../widgets/important_notifications.dart';

class DashboardAdmin extends StatefulWidget {
  const DashboardAdmin({super.key});

  @override
  State<DashboardAdmin> createState() => _DashboardAdminState();
}

class _DashboardAdminState extends State<DashboardAdmin> {
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
      QuickAlert.show(
          context: context,
          type: QuickAlertType.warning,
          title: 'Sesi Berakhir',
          text: 'Silakan login kembali.',
          confirmBtnText: 'Login Ulang',
          onConfirmBtnTap: () {
            logoutAndRedirect(context);
          });
    } else {
      setState(() {
        _isLoading = false;
      });
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
      // backgroundColor: const Color(0xFFF6F6F6),
      body: SingleChildScrollView(
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // SizedBox(height: 20.h),
            const AdminHeader(),
            SizedBox(height: 10.h),
            Transform.translate(
              offset: Offset(0, -180.h),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                child: AdminProfileCard(screenWidth: screenWidth),
              ),
            ),
            Transform.translate(
              offset: Offset(0, -155.h),
              child: const QuickActions(),
            ),
            SizedBox(height: 10.h),
            Transform.translate(
              offset: Offset(0, -105.h),
              child: const ImportantNotifications(),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}