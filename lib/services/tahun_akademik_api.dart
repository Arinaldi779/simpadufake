import 'dart:convert';
import 'package:http/http.dart' as http;

class TahunAkademikApi {
  static const String baseUrl = 'http://36.91.27.150:815/api/tahun-akademik';

  static Future<List<dynamic>> fetchTahunAkademik() async {
    final response = await http.get(Uri.parse(baseUrl));
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['success'] == true) {
        return data['data'];
      } else {
        throw Exception(data['message']);
      }
    } else {
      throw Exception('Failed to load academic years. Status: ${response.statusCode}');
    }
  }

  static Future<void> addTahunAkademik(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add academic year. Status: ${response.statusCode}');
    }
  }

  static Future<void> updateTahunAkademik(String id, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update academic year. Status: ${response.statusCode}');
    }
  }

  static Future<void> setAktif(String id) async {
    final response = await http.patch(
      Uri.parse('$baseUrl/$id/set-aktif'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to set academic year active. Status: ${response.statusCode}');
    }
  }
}
