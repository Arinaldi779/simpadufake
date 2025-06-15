import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/mahasiswa_model.dart';

class MahasiswaService {
  final String baseUrl = 'https://ti054d01.agussbn.my.id/api';
  String? _token;

  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
  }

  Future<List<Mahasiswa>> fetchMahasiswa() async {
    await _loadToken();
    final response = await http.get(
      Uri.parse('$baseUrl/kls-master'),
      headers: {
        'Authorization': 'Bearer $_token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final List<dynamic> data = json['data'];
      return data.map((item) => Mahasiswa.fromJson(item)).toList();
    } else {
      throw Exception('Gagal memuat data mahasiswa');
    }
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

  Future<void> tambahMahasiswa(Mahasiswa mahasiswa) async {
    await _loadToken();
    final response = await http.post(
      Uri.parse('$baseUrl/kls-master'),
      headers: {
        'Authorization': 'Bearer $_token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(mahasiswa.toJson()),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Gagal menambahkan mahasiswa');
    }
  }
}