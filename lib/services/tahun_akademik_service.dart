import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '/models/tahun_akademik_model.dart';

class TahunAkademikService {
  final String baseUrl = 'https://ti054d01.agussbn.my.id/api';

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Fetch daftar tahun akademik
  Future<List<TahunAkademik>> fetchTahunAkademik() async {
    final token = await _getToken();
    if (token == null || token.isEmpty) {
      throw Exception('401|Token tidak ditemukan');
    }

    try {
      final response = await http
          .get(
            Uri.parse('$baseUrl/tahun-akademik'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          return (data['data'] as List)
              .map((item) => TahunAkademik.fromJson(item))
              .toList();
        } else {
          throw Exception('400|${data['message'] ?? 'Gagal mengambil data'}');
        }
      } else {
        String message = _defaultErrorMessage(response.statusCode);
        try {
          final errorBody = json.decode(response.body);
          message = errorBody['message'] ?? message;
        } catch (_) {}
        throw Exception('${response.statusCode}|$message');
      }
    } on TimeoutException {
      throw Exception('504|Server tidak merespons');
    } on http.ClientException {
      throw Exception('503|Tidak ada koneksi internet');
    } catch (e) {
      throw Exception('500|${e.toString()}');
    }
  }

  String _defaultErrorMessage(int statusCode) {
    switch (statusCode) {
      case 400:
        return 'Permintaan tidak valid (400 Bad Request)';
      case 401:
        return 'Sesi Anda telah berakhir. Silakan login ulang.';
      case 403:
        return 'Akses ditolak (403 Forbidden)';
      case 404:
        return 'Data tidak ditemukan (404 Not Found)';
      case 500:
        return 'Terjadi kesalahan pada server (500 Internal Server Error)';
      case 502:
        return 'Bad Gateway (502)';
      case 503:
        return 'Layanan tidak tersedia (503 Service Unavailable)';
      case 504:
        return 'Gateway Timeout (504)';
      case 521:
        return 'Web server sedang down (521)';
      default:
        return 'Terjadi kesalahan ($statusCode)';
    }
  }

  // Menambahkan tahun akademik baru
  Future<void> addTahunAkademik(TahunAkademik tahunAkademik) async {
    final token = await _getToken();
    if (token == null || token.isEmpty) {
      throw Exception('Token tidak ditemukan');
    }

    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/createthnak'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
            body: json.encode(tahunAkademik.toJson()),
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(
          'Gagal menambahkan tahun akademik: ${response.statusCode}',
        );
      }
    } on TimeoutException {
      throw Exception('Server tidak merespons');
    } catch (e) {
      throw Exception('Error saat tambah data: $e');
    }
  }

  // Mengupdate status tahun akademik
  Future<void> updateTahunAkademik(String id, bool isAktif) async {
    final token = await _getToken();
    if (token == null || token.isEmpty) {
      throw Exception('Token tidak ditemukan');
    }

    try {
      final response = await http
          .put(
            Uri.parse('$baseUrl/tahun-akademik/$id'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
            body: json.encode({'status': isAktif ? 'Y' : 'T'}),
          )
          .timeout(const Duration(seconds: 30));

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode != 200) {
        throw Exception(
          'Gagal memperbarui tahun akademik: ${response.statusCode}',
        );
      }
    } on TimeoutException {
      throw Exception('Server tidak merespons');
    } catch (e) {
      throw Exception('Error saat update data: $e');
    }
  }
}
