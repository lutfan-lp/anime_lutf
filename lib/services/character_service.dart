import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/character.dart';

class CharacterService {
  static Future<List<Character>> fetchTopCharacters(int page) async {
    final url = Uri.parse('https://api.jikan.moe/v4/top/characters?page=$page&limit=6');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List list = jsonData['data'];
      return list.map((e) => Character.fromJson(e)).toList();
    } else {
      throw Exception('Gagal mengambil data karakter');
    }
  }
}
