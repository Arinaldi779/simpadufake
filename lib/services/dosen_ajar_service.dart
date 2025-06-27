import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/dosen_ajar_model.dart';

class DosenAjarService {
  final String baseUrl = 'https://ti054d01.agussbn.my.id/api ';
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

  Future<List<DosenAjar>> fetchDosenAjar() async {
    await _loadToken();
    final url = Uri.parse('$baseUrl/dosen-ajar');
    try {
      final response = await http
          .get(
            url,
            headers: {
              'Authorization': 'Bearer $_token',
              'Accept': 'application/json',
            },
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success'] == true &&
            jsonResponse.containsKey('data')) {
          final List<dynamic> dataList = jsonResponse['data'];
          return dataList.map((item) => DosenAjar.fromJson(item)).toList();
        } else {
          throw Exception(jsonResponse['message'] ?? 'Data tidak ditemukan');
        }
      } else {
        String message = _defaultErrorMessage(response.statusCode);
        try {
          final errorBody = jsonDecode(response.body);
          message = errorBody['message'] ?? message;
        } catch (_) {}
        throw Exception('${response.statusCode}|$message');
      }
    } catch (e) {
      throw Exception('500|${e.toString()}');
    }
  }

  Future<List<PegawaiRingkas>> fetchPegawai() async {
    await _loadToken();
    final url = Uri.parse(
      'https://ti054d02.agussbn.my.id/api/pegawai-ringkas ',
    );
    try {
      final response = await http
          .get(
            url,
            headers: {
              'Authorization': 'Bearer $_token',
              'Accept': 'application/json',
            },
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success'] == true &&
            jsonResponse.containsKey('data')) {
          final List<dynamic> dataList = jsonResponse['data'];
          return dataList.map((item) => PegawaiRingkas.fromJson(item)).toList();
        } else {
          throw Exception('Gagal memuat pegawai');
        }
      } else {
        String message = _defaultErrorMessage(response.statusCode);
        try {
          final errorBody = jsonDecode(response.body);
          message = errorBody['message'] ?? message;
        } catch (_) {}
        throw Exception('${response.statusCode}|$message');
      }
    } catch (e) {
      throw Exception('500|${e.toString()}');
    }
  }

  Future<List<Kelas>> fetchKelas() async {
    await _loadToken();
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
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success'] == true &&
            jsonResponse.containsKey('data')) {
          final List<dynamic> dataList = jsonResponse['data'];
          return dataList.map((item) => Kelas.fromJson(item)).toList();
        } else {
          throw Exception('Gagal memuat kelas');
        }
      } else {
        String message = _defaultErrorMessage(response.statusCode);
        try {
          final errorBody = jsonDecode(response.body);
          message = errorBody['message'] ?? message;
        } catch (_) {}
        throw Exception('${response.statusCode}|$message');
      }
    } catch (e) {
      throw Exception('500|${e.toString()}');
    }
  }

  Future<List<Kurikulum>> fetchKurikulum() async {
    await _loadToken();
    final url = Uri.parse('$baseUrl/siap-kurikulum');
    try {
      final response = await http
          .get(
            url,
            headers: {
              'Authorization': 'Bearer $_token',
              'Accept': 'application/json',
            },
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success'] == true &&
            jsonResponse.containsKey('data')) {
          final List<dynamic> dataList = jsonResponse['data'];
          return dataList.map((item) => Kurikulum.fromJson(item)).toList();
        } else {
          throw Exception('Gagal memuat kurikulum');
        }
      } else {
        String message = _defaultErrorMessage(response.statusCode);
        try {
          final errorBody = jsonDecode(response.body);
          message = errorBody['message'] ?? message;
        } catch (_) {}
        throw Exception('${response.statusCode}|$message');
      }
    } catch (e) {
      throw Exception('500|${e.toString()}');
    }
  }

  Future<void> tambahDosenAjar({
    required int idKelas,
    required int idPegawai,
    required int idKurikulum,
  }) async {
    await _loadToken();
    final url = Uri.parse('$baseUrl/dosen-ajar');
    final body = jsonEncode({
      'id_kelas': idKelas,
      'id_pegawai': idPegawai,
      'id_kurikulum': idKurikulum,
    });

    try {
      final response = await http
          .post(
            url,
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $_token',
            },
            body: body,
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return;
      } else {
        String message = _defaultErrorMessage(response.statusCode);
        try {
          final errorBody = jsonDecode(response.body);
          message = errorBody['message'] ?? message;
        } catch (_) {}
        throw Exception('${response.statusCode}|$message');
      }
    } catch (e) {
      throw Exception('500|${e.toString()}');
    }
  }
}
