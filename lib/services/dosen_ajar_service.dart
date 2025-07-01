// services/dosen_ajar_service.dart
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/dosen_ajar_model.dart';

class DosenAjarService {
  final String baseUrl = 'https://ti054d01.agussbn.my.id/api';
  final String baseUrlPegawai = 'https://ti054d02.agussbn.my.id/api';
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

  // Fetch semua dosen ajar
  Future<List<DosenAjar>> fetchDosenAjars() async {
    await _loadToken();

    if (_token == null || _token!.isEmpty) {
      throw Exception('401|Token tidak tersedia');
    }

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
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse.containsKey('data')) {
          final List<dynamic> data = jsonResponse['data'];
          return data.map((item) => DosenAjar.fromJson(item)).toList();
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
  Future<DropdownDosenAjarData> fetchDropdownData() async {
    await _loadToken();

    final urlKelasKurikulum = Uri.parse('$baseUrl/kls-mk');
    final urlPegawai = Uri.parse('$baseUrlPegawai/pegawai-ringkas');

    try {
      // Fetch data kelas dan kurikulum
      final responseKelasKurikulum = await http
          .get(
            urlKelasKurikulum,
            headers: {
              'Authorization': 'Bearer $_token',
              'Accept': 'application/json',
            },
          )
          .timeout(const Duration(seconds: 30));

      // Fetch data pegawai
      final responsePegawai = await http
          .get(
            urlPegawai,
            headers: {
              'Authorization': 'Bearer $_token',
              'Accept': 'application/json',
            },
          )
          .timeout(const Duration(seconds: 30));

      if (responseKelasKurikulum.statusCode == 200 && 
          responsePegawai.statusCode == 200) {
        // Parse data kelas dan kurikulum
        final jsonKelasKurikulum = jsonDecode(responseKelasKurikulum.body);
        final List<KurikulumKelas> kurikulumList =
            (jsonKelasKurikulum['dataKurikulum'] as List)
                .map((kurikulum) => KurikulumKelas.fromJson(kurikulum))
                .toList();

        final List<Kelas> kelasList =
            (jsonKelasKurikulum['dataKelas'] as List)
                .map((kelas) => Kelas.fromJson(kelas))
                .toList();

        // Parse data pegawai
        final jsonPegawai = jsonDecode(responsePegawai.body);
        final List<Pegawai> pegawaiList =
            (jsonPegawai as List)
                .map((pegawai) => Pegawai.fromJson(pegawai))
                .toList();

        return DropdownDosenAjarData(
          pegawaiList: pegawaiList,
          kelasList: kelasList,
          kurikulumList: kurikulumList,
        );
      } else {
        String message = '';
        if (responseKelasKurikulum.statusCode != 200) {
          message = _defaultErrorMessage(responseKelasKurikulum.statusCode);
          try {
            final errorBody = jsonDecode(responseKelasKurikulum.body);
            message = errorBody['message'] ?? message;
          } catch (_) {}
        } else {
          message = _defaultErrorMessage(responsePegawai.statusCode);
          try {
            final errorBody = jsonDecode(responsePegawai.body);
            message = errorBody['message'] ?? message;
          } catch (_) {}
        }
        throw Exception('${responseKelasKurikulum.statusCode}|$message');
      }
    } on TimeoutException {
      throw Exception('504|Server tidak merespons dalam waktu yang ditentukan');
    } on http.ClientException {
      throw Exception('503|Tidak ada koneksi internet');
    } catch (e) {
      throw Exception('500|${e.toString()}');
    }
  }

  // Menambahkan dosen ajar baru
  Future<void> tambahDosenAjar({
    required int idKelas,
    required int idKurikulum,
    required int idPegawai,
  }) async {
    await _loadToken();

    if (_token == null || _token!.isEmpty) {
      throw Exception('401|Token tidak tersedia');
    }

    final url = Uri.parse('$baseUrl/dosen-ajar');
    final body = jsonEncode({
      'id_kelas': idKelas,
      'id_kurikulum': idKurikulum,
      'id_pegawai': idPegawai,
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