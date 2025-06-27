import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/daftar_kelas_model.dart';

class KelasService {
  final String baseUrl = 'https://ti054d01.agussbn.my.id/api';
  String? _token;

  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
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

  // Fetch semua kelas
  Future<List<Kelas>> fetchKelas() async {
    await _loadToken();

    if (_token == null || _token!.isEmpty) {
      throw Exception('401|Token tidak ditemukan');
    }

    final url = Uri.parse('$baseUrl/siapkelas');

    try {
      final response = await http
          .get(
            url,
            headers: {
              'Authorization': 'Bearer $_token',
              'Accept': 'application/json',
            },
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final List<dynamic> data = json['data'];
        return data.map((item) => Kelas.fromJson(item)).toList();
      } else {
        String message = _defaultErrorMessage(response.statusCode);
        try {
          final errorBody = jsonDecode(response.body);
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

  // Ambil data dropdown prodi dan tahun akademik
  Future<Map<String, dynamic>> fetchProdiDanTahunAkademik() async {
    await _loadToken();

    if (_token == null || _token!.isEmpty) {
      throw Exception('401|Token tidak ditemukan');
    }

    final url = Uri.parse('$baseUrl/thnak-prodi');

    try {
      final response = await http
          .get(
            url,
            headers: {
              'Authorization': 'Bearer $_token',
              'Accept': 'application/json',
            },
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        final prodiList =
            (json['dataProdi'] as List)
                .map((item) => Prodi.fromJson(item))
                .toList();

        final taList =
            (json['dataTahunAkademik'] as List)
                .map((item) => TahunAkademik.fromJson(item))
                .toList();

        return {'prodiList': prodiList, 'tahunAkademikList': taList};
      } else {
        String message = _defaultErrorMessage(response.statusCode);
        try {
          final errorBody = jsonDecode(response.body);
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

  // Menambahkan kelas baru
  Future<void> tambahKelas(Kelas kelas) async {
    await _loadToken();

    if (_token == null || _token!.isEmpty) {
      throw Exception('401|Token tidak ditemukan');
    }

    final url = Uri.parse('$baseUrl/siapkelas');

    try {
      final response = await http
          .post(
            url,
            headers: {
              'Authorization': 'Bearer $_token',
              'Accept': 'application/json',
              'Content-Type': 'application/json',
            },
            body: jsonEncode(kelas.toJson()),
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode != 200 && response.statusCode != 201) {
        String message = _defaultErrorMessage(response.statusCode);
        try {
          final responseBody = jsonDecode(response.body);
          message = responseBody['message'] ?? message;
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
}

// Model helper untuk respons gabungan
class ProdiTahunAkademikResponse {
  final List<Prodi> prodiList;
  final List<TahunAkademik> tahunAkademikList;

  ProdiTahunAkademikResponse({
    required this.prodiList,
    required this.tahunAkademikList,
  });
}
