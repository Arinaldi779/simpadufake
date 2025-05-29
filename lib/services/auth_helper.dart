// lib/services/auth_helper.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Fungsi untuk logout dan redirect ke halaman login
void logoutAndRedirect(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('token'); // Hapus token dari SharedPreferences

  // Arahkan ke halaman login dan hapus riwayat navigasi
  Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
}

// Fungsi untuk memeriksa apakah token valid
Future<bool> isTokenValid() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');
  return token != null && token.isNotEmpty;
}