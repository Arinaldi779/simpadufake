// lib/auth_middleware.dart

import 'package:shared_preferences/shared_preferences.dart';

Future<bool> isTokenValid() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');
  return token != null && token.isNotEmpty;
}