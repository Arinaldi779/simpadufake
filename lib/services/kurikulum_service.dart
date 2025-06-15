// kurikulum_service.dart
import 'dart:convert';
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

  // Fungsi fetchKurikulums
  Future<List<Kurikulum>> fetchKurikulums({
    required String namaKelas,
    required String idTahunAkademik,
    required String idProdi,
    required String alias,
  }) async {
    await _loadToken();

    final url = Uri.parse('$baseUrl/siap-kurikulum');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $_token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] && data['data'] != null) {
          return List<Kurikulum>.from(
            (data['data'] as List).map((item) => Kurikulum.fromJson(item)),
          );
        } else {
          throw Exception('Gagal memuat data kurikulum');
        }
      } else {
        throw Exception('Gagal memuat data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error saat memanggil API: $e');
    }
  }

  // Fungsi tambahKurikulum
  Future<void> tambahKurikulum({
    required String namaKelas,
    required String idTahunAkademik,
    required String idProdi,
    required String alias,
  }) async {
    await _loadToken(); // ← Gunakan token dari _loadToken()

    final url = Uri.parse('$baseUrl/tambah-kurikulum');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token', // ← Gunakan token lokal
      },
      body: jsonEncode({
        'nama_kelas': namaKelas,
        'id_tahun_akademik': idTahunAkademik,
        'id_prodi': idProdi,
        'alias': alias,
      }),
    );

    if (response.statusCode == 401) {
      throw Exception('Unauthorized');
    }

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Gagal menambahkan kurikulum');
    }
  }
}