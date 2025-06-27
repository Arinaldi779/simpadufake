import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/kurikulum_model.dart';

class KurikulumService {
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

  // Fetch semua kurikulum
  Future<List<Kurikulum>> fetchKurikulums() async {
    await _loadToken();

    if (_token == null || _token!.isEmpty) {
      throw Exception('401|Token tidak tersedia');
    }

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
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse.containsKey('data')) {
          final List<dynamic> data = jsonResponse['data'];
          return data.map((item) => Kurikulum.fromJson(item)).toList();
        } else {
          throw Exception(
            '400|Format respons tidak valid: Tidak ada kunci "data"',
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

  // Ambil data dropdown
  Future<DropdownData> fetchDropdownData() async {
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

        final List<MataKuliah> matakuliahList =
            (jsonBody['dataMk'] as List)
                .map((mk) => MataKuliah.fromJson(mk))
                .toList();

        final List<Prodi> prodiList =
            (jsonBody['dataProdi'] as List)
                .map((prodi) => Prodi.fromJson(prodi))
                .toList();

        final List<TahunAkademik> tahunAkademikList =
            (jsonBody['dataTahunAkademik'] as List)
                .map((ta) => TahunAkademik.fromJson(ta))
                .toList();

        return DropdownData(
          matakuliahList: matakuliahList,
          prodiList: prodiList,
          tahunAkademikList: tahunAkademikList,
        );
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

  // Menambahkan kurikulum baru
  Future<void> tambahKurikulum({
    required int idMk,
    required int idThnAk,
    required int idProdi,
    required String ket,
  }) async {
    await _loadToken();

    if (_token == null || _token!.isEmpty) {
      throw Exception('401|Token tidak tersedia');
    }

    final url = Uri.parse('$baseUrl/siap-kurikulum');
    final body = jsonEncode({
      'id_mk': idMk,
      'id_thn_ak': idThnAk,
      'id_prodi': idProdi,
      'ket': ket,
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

      if (response.statusCode != 200 && response.statusCode != 201) {
        String message = _defaultErrorMessage(response.statusCode);
        try {
          final responseBody = jsonDecode(response.body);
          message = responseBody['message'] ?? message;
        } catch (_) {}
        throw Exception('${response.statusCode}|$message');
      }
    } on TimeoutException {
      throw Exception('504|Server tidak merespons dalam waktu yang ditentukan');
    } catch (e) {
      throw Exception('500|${e.toString()}');
    }
  }
}
