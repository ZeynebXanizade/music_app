import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {
  static const _favoritesKey = 'favorite_tracks';

  Future<List<Map<String, dynamic>>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_favoritesKey);
    if (jsonString == null) return [];

    final List decoded = json.decode(jsonString);
    return decoded.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  Future<void> addFavorite(Map<String, dynamic> track) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavorites();

    if (favorites.any((t) => t['previewUrl'] == track['previewUrl'])) return;

    favorites.add(track);
    await prefs.setString(_favoritesKey, json.encode(favorites));
  }

  Future<void> removeFavorite(String previewUrl) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavorites();
    favorites.removeWhere((t) => t['previewUrl'] == previewUrl);
    await prefs.setString(_favoritesKey, json.encode(favorites));
  }

  Future<bool> isFavorite(String previewUrl) async {
    final favorites = await getFavorites();
    return favorites.any((t) => t['previewUrl'] == previewUrl);
  }
}
