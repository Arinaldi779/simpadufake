import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = 'http://36.91.27.150:815/api';
  
  // Login method
  static Future<Map<String, dynamic>> login(String emailOrNip, String password) async {
    final url = Uri.parse('$baseUrl/login');
    
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email_or_nip': emailOrNip, 'password': password}),
      ).timeout(const Duration(seconds: 30));

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      final data = jsonDecode(response.body);
      
      if (response.statusCode == 200 && data['success'] == true) {
        final token = data['token'];
        final user = data['user'];
        final namaUser = user['nama_lengkap'];
        final role = user['role'];
        final idUser = user['id_user'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString('namaUser', namaUser);
        await prefs.setString('role', role);
        await prefs.setString('idUser', idUser.toString());

        print('Token saved: ${prefs.getString('token')}');

        return {
          'success': true,
          'token': token,
          'namaUser': namaUser,
          'role': role,
          'idUser': idUser,
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Login gagal',
        };
      }
    } on TimeoutException {
      return {
        'success': false,
        'message': 'Timeout: Server tidak merespon',
      };
    } catch (e) {
      print('Error during login: $e');
      return {
        'success': false,
        'message': 'Error: ${e.toString()}',
      };
    }
  }

  // Method to save user credentials (for "Remember Me" functionality)
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

  // Method to load saved credentials
  static Future<Map<String, dynamic>> loadSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final isRemembered = prefs.getBool('isRemembered') ?? false;
    
    if (isRemembered) {
      return {
        'isRemembered': true,
        'email': prefs.getString('savedEmail') ?? '',
        'password': prefs.getString('savedPassword') ?? '',
      };
    } else {
      return {
        'isRemembered': false,
        'email': '',
        'password': '',
      };
    }
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    try {
      final response = await http.post(
        Uri.parse('http://36.91.27.150:815/api/logout'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      // Hapus token setelah logout
      await prefs.remove('token');
      await prefs.remove('namaUser');
      await prefs.remove('role');
      await prefs.remove('idUser');
    } catch (e) {
      // Jika gagal logout, tetap hapus token dan data user
      await prefs.remove('token');
      await prefs.remove('namaUser');
      await prefs.remove('role');
      await prefs.remove('idUser');
    }
  }
}