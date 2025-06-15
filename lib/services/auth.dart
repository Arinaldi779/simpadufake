import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = 'https://ti054d01.agussbn.my.id/api';

  // Method Login
  static Future<Map<String, dynamic>> login(String emailOrNip, String password) async {
    final url = Uri.parse('$baseUrl/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': emailOrNip, 'password': password}),
      ).timeout(const Duration(seconds: 30));

      // Logging untuk debugging
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.body.isEmpty) {
        return {'success': false, 'message': 'Server tidak memberikan respon'};
      }

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        final token = data['token'];
        final user = data['user'] as Map<String, dynamic>?;

        if (user == null || user.isEmpty) {
          return {'success': false, 'message': 'Data pengguna tidak ditemukan'};
        }

        final idUser = user['id_user']?.toString() ?? '';
        final email = user['email'] ?? '';
        final role = user['role'] ?? 'Pengguna';
        final namaUser = user['nama_lengkap'] ?? email;

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString('idUser', idUser);
        await prefs.setString('email', email);
        await prefs.setString('role', role);
        await prefs.setString('namaUser', namaUser);

        return {
          'success': true,
          'token': token,
          'idUser': idUser,
          'email': email,
          'role': role,
          'namaUser': namaUser,
        };
      } else {
        return {'success': false, 'message': data['message'] ?? 'Login gagal'};
      }
    } on TimeoutException {
      return {'success': false, 'message': 'Timeout: Server tidak merespons'};
    } catch (e, stackTrace) {
      print('Error saat login: $e');
      print('Stack trace: $stackTrace');
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  // Simpan kredensial jika "Ingat Saya" dicentang
  static Future<void> saveUserCredentials(String email, String password, bool remember) async {
    final prefs = await SharedPreferences.getInstance();

    if (remember) {
      await prefs.setBool('isRemembered', true);
      await prefs.setString('savedEmail', email);
      await prefs.setString('savedPassword', password);
    } else {
      await prefs.setBool('isRemembered', false);
      await prefs.remove('savedEmail');
      await prefs.remove('savedPassword');
    }
  }

  // Muat kredensial yang tersimpan
  static Future<Map<String, dynamic>> loadSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final isRemembered = prefs.getBool('isRemembered') ?? false;

    return {
      'isRemembered': isRemembered,
      'email': prefs.getString('savedEmail') ?? '',
      'password': prefs.getString('savedPassword') ?? '',
    };
  }

  // Logout
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    try {
      if (token != null && token.isNotEmpty) {
        await http.post(
          Uri.parse('$baseUrl/logout'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );
      }
    } catch (e) {
      // Biarkan tetap lanjut meskipun server error;
    } finally {
      await prefs.clear(); // Bersihkan semua data lokal
    }
  }
}