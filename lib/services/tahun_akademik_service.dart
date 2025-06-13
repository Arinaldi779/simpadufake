  import 'dart:convert';
  import 'package:http/http.dart' as http;
  import 'package:shared_preferences/shared_preferences.dart';
  import '/models/tahun_akademik_model.dart';

  class TahunAkademikService {
    final String baseUrl = 'https://ti054d01.agussbn.my.id/api';

    // Fungsi untuk mendapatkan token dari shared preferences
    Future<String?> _getToken() async {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString('token');
    }

    // Mengambil data tahun akademik dari API
    Future<List<TahunAkademik>> fetchTahunAkademik() async {
      final token = await _getToken();
      final response = await http.get(
        Uri.parse('$baseUrl/tahun-akademik'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          return (data['data'] as List)
              .map((item) => TahunAkademik.fromJson(item))
              .toList();
        } else {
          throw Exception(data['message']);
        }
      } else {
        throw Exception('Gagal memuat data: ${response.statusCode}');
      }
    }

    // Menambahkan tahun akademik baru
    Future<void> addTahunAkademik(TahunAkademik tahunAkademik) async {
      final token = await _getToken();
      final response = await http.post(
        Uri.parse('$baseUrl/createthnak'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(tahunAkademik.toJson()),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Tahun akademik sudah ada: ${response.statusCode}');
      }
    }

    // Mengupdate status tahun akademik
    Future<void> updateTahunAkademik(String id, bool isAktif) async {
      final token = await _getToken();
      final response = await http.put(
        Uri.parse('$baseUrl/tahun-akademik/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({'status': isAktif ? 'Y' : 'T'}),
      );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode != 200) {
        throw Exception('Gagal memperbarui tahun akademik: \${response.statusCode}');
      }
    }
  }