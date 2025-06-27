import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/matakuliah_model.dart';

class MataKuliahService {
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

  // Fetch all mata kuliah
  Future<List<MataKuliah>> fetchMataKuliahs() async {
    await _loadToken();

    if (_token == null || _token!.isEmpty) {
      throw Exception('401|Token tidak tersedia');
    }

    final url = Uri.parse('$baseUrl/siapmk');

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
        if (jsonResponse['success'] == true) {
          if (jsonResponse.containsKey('data')) {
            final List<dynamic> dataList = jsonResponse['data'];
            return dataList.map((item) => MataKuliah.fromJson(item)).toList();
          } else {
            throw Exception(
              '400|Format respons tidak valid: Tidak ada kunci "data"',
            );
          }
        } else {
          throw Exception(
            '400|${jsonResponse['message'] ?? 'Gagal memuat data mata kuliah'}',
          );
        }
      } else {
        String message = _defaultErrorMessage(response.statusCode);
        try {
          final errorBody = jsonDecode(response.body);
          message = errorBody['message'] ?? message;
        } catch (_) {}
        throw Exception('${response.statusCode}|$message');
      }
    } on TimeoutException {
      throw Exception('504|Server tidak merespons dalam waktu yang ditentukan');
    } on http.ClientException {
      throw Exception('503|Tidak ada koneksi internet');
    } catch (e) {
      throw Exception('500|${e.toString()}');
    }
  }

  // Get mata kuliah detail by ID
  Future<MataKuliah> getMataKuliahDetail(int idMk) async {
    await _loadToken();

    if (_token == null || _token!.isEmpty) {
      throw Exception('401|Token tidak tersedia');
    }

    final url = Uri.parse('$baseUrl/siapmk/$idMk');

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
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse['success'] == true) {
          return MataKuliah.fromJson(jsonResponse['data']);
        } else {
          throw Exception(
            '400|${jsonResponse['message'] ?? 'Gagal memuat detail mata kuliah'}',
          );
        }
      } else {
        String message = _defaultErrorMessage(response.statusCode);
        try {
          final errorBody = jsonDecode(response.body);
          message = errorBody['message'] ?? message;
        } catch (_) {}
        throw Exception('${response.statusCode}|$message');
      }
    } on TimeoutException {
      throw Exception('504|Server tidak merespons dalam waktu yang ditentukan');
    } on http.ClientException {
      throw Exception('503|Tidak ada koneksi internet');
    } catch (e) {
      throw Exception('500|${e.toString()}');
    }
  }

  // Get dropdown data (prodi)
  Future<DropdownDataMk> fetchDropdownData() async {
    await _loadToken();

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
        final jsonBody = jsonDecode(response.body);

        final List<Prodi> prodiList =
            (jsonBody['dataProdi'] as List)
                .map((prodi) => Prodi.fromJson(prodi))
                .toList();

        return DropdownDataMk(prodiList: prodiList);
      } else {
        String message = _defaultErrorMessage(response.statusCode);
        try {
          final errorBody = jsonDecode(response.body);
          message = errorBody['message'] ?? message;
        } catch (_) {}
        throw Exception('${response.statusCode}|$message');
      }
    } on TimeoutException {
      throw Exception('504|Server tidak merespons dalam waktu yang ditentukan');
    } on http.ClientException {
      throw Exception('503|Tidak ada koneksi internet');
    } catch (e) {
      throw Exception('500|${e.toString()}');
    }
  }

  Future<void> tambahMataKuliah({
    required String kodeMk,
    required String namaMk,
    required int idProdi,
    required int sks,
    required int jam,
  }) async {
    await _loadToken();

    if (_token == null || _token!.isEmpty) {
      throw Exception('401|Token tidak tersedia');
    }

    final url = Uri.parse('$baseUrl/siapmk');

    final body = jsonEncode({
      'kode_mk': kodeMk,
      'nama_mk': namaMk,
      'id_prodi': idProdi,
      'sks': sks,
      'jam': jam,
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
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return;
      } else {
        String message = _defaultErrorMessage(response.statusCode);
        try {
          final responseBody = jsonDecode(response.body);
          message = responseBody['message'] ?? message;
        } catch (_) {}
        throw Exception('${response.statusCode}|$message');
      }
    } on TimeoutException catch (_) {
      throw Exception('504|Timeout: Server tidak merespons');
    } on http.ClientException catch (_) {
      throw Exception('503|Tidak ada koneksi internet');
    } catch (e) {
      throw Exception('500|${e.toString()}');
    }
  }
}
