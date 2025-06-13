import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quickalert/quickalert.dart';


void logoutAndRedirect(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();
  if (context.mounted) {
    Navigator.pushReplacementNamed(context, '/login');
  }
}

void handleUnauthorized(BuildContext context) {
  if (!context.mounted || ModalRoute.of(context)?.isCurrent == false) return;

  QuickAlert.show(
    context: context,
    type: QuickAlertType.warning,
    title: 'Sesi Berakhir',
    text: 'Silakan login kembali.',
    confirmBtnText: 'Login Ulang',
    onConfirmBtnTap: () {
      logoutAndRedirect(context);
    },
  );
}