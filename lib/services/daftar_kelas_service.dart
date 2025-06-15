import 'dart:convert';
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

  Future<List<Kelas>> fetchKelas() async {
    await _loadToken();
    final response = await http.get(
      Uri.parse('$baseUrl/siapkelas'),
      headers: {
        'Authorization': 'Bearer $_token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final List<dynamic> data = json['data'];
      return data.map((item) => Kelas.fromJson(item)).toList();
    } else {
      throw Exception('Gagal memuat data kelas');
    }
  }

  Future<Map<String, dynamic>> fetchProdiDanTahunAkademik() async {
    await _loadToken();
    final response = await http.get(
      Uri.parse('$baseUrl/thnak-prodi'),
      headers: {
        'Authorization': 'Bearer $_token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return {
        'prodiList': (json['dataProdi'] as List)
            .map((item) => Prodi.fromJson(item))
            .toList(),
        'tahunAkademikList': (json['dataTahunAkademik'] as List)
            .map((item) => TahunAkademik.fromJson(item))
            .toList(),
      };
    } else {
      throw Exception('Gagal memuat data prodi dan tahun akademik');
    }
  }

  Future<void> tambahKelas(Kelas kelas) async {
    await _loadToken();
    final response = await http.post(
      Uri.parse('$baseUrl/siapkelas'),
      headers: {
        'Authorization': 'Bearer $_token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(kelas.toJson()),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Gagal menambahkan kelas');
    }
  }
}