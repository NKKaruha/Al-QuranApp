import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://api.alquran.cloud/v1";

  Future<List<dynamic>> fetchSurah() async {
    final response = await http.get(Uri.parse("$baseUrl/surah"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    }
    throw Exception("Failed to load Surah");
  }

  Future<List<dynamic>> fetchJuz() async {
    final response = await http.get(Uri.parse("$baseUrl/juz"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    }
    throw Exception("Failed to load Juz");
  }

  Future<Map<String, dynamic>> fetchJuzDetail(int juz, String edition) async {
    final response = await http.get(Uri.parse("$baseUrl/juz/$juz/$edition"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    }
    throw Exception("Failed to load Juz detail");
  }

  Future<Map<String, dynamic>> fetchSurahDetail(int id) async {
    final response = await http.get(Uri.parse("$baseUrl/surah/$id"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    }
    throw Exception("Failed to load Surah detail");
  }
}
