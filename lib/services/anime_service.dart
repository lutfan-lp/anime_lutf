import 'dart:convert';
import 'package:anime_trending_app/models/character.dart';
import 'package:http/http.dart' as http;
import '../models/anime.dart';

class AnimeService {
  static Future<List<Anime>> getTopAnime(int page) async {
    final response = await http.get(
      Uri.parse('https://api.jikan.moe/v4/top/anime?page=$page&limit=6'),
    );

    final data = jsonDecode(response.body);
    return (data['data'] as List).map((e) => Anime.fromJson(e)).toList();
  }

  static Future<List<Character>> getTopCharacters(int page) async {
    final response = await http.get(
      Uri.parse('https://api.jikan.moe/v4/top/characters?page=$page&limit=6'),
    );

    final data = jsonDecode(response.body);
    return (data['data'] as List).map((e) => Character.fromJson(e)).toList();
  }

  static Future<List<Anime>> searchAnime(String query, int page) async {
    final response = await http.get(
      Uri.parse('https://api.jikan.moe/v4/anime?q=$query&page=$page'),
    );

    final data = json.decode(response.body);
    final List list = data['data'];

    return list.map((e) => Anime.fromJson(e)).toList();
  }
}
