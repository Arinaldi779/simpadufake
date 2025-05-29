import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/kelas_model.dart';

class KelasService {
  final String baseUrl = 'http://36.91.27.150:815/api';

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Fetch semua kelas
  Future<List<Kelas>> fetchKelasList() async {
    final token = await _getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/siapkelas'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['success']) {
        List<dynamic> kelasData = data['data'];
        return kelasData.map((json) => Kelas.fromJson(json)).toList();
      } else {
        throw Exception(data['message']);
      }
    } else {
      throw Exception('Gagal memuat data kelas: ${response.statusCode}');
    }
  }

  // Tambah kelas baru
  Future<void> addKelas(Kelas kelas) async {
    final token = await _getToken();
    final response = await http.post(
      Uri.parse('$baseUrl/siapkelas'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(kelas.toJson()),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Gagal menambah kelas: ${response.statusCode} - ${response.body}');
    }
  }

  // Edit kelas
  Future<void> editKelas(String id_kelas, Kelas kelas) async {
    final token = await _getToken();
    final response = await http.put(
      Uri.parse('$baseUrl/siapkelas/$id_kelas'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(kelas.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Gagal mengedit kelas: ${response.statusCode}');
    }
  }

  // Ambil prodi & tahun akademik
  Future<Map<String, dynamic>> getProdiAndTahunAkademik() async {
    final token = await _getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/thnak-prodi'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['success']) {
        return {
          'prodiList': data['dataProdi'],
          'tahunAkademikList': data['dataTahunAkademik'],
        };
      } else {
        throw Exception(data['message']);
      }
    } else {
      throw Exception('Gagal memuat data Prodi & Tahun Akademik: ${response.statusCode}');
    }
  }
}