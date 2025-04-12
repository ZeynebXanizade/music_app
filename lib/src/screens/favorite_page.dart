import 'package:flutter/material.dart';
import 'package:music_app/l10n/app_localizations.dart';
import 'package:music_app/src/services/favorite_services.dart';

import 'music_player_page.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final FavoritesService _favoritesService = FavoritesService();
  List<Map<String, dynamic>> _favorites = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final favs = await _favoritesService.getFavorites();
    setState(() {
      _favorites = favs;
    });
  }

  Future<void> _removeFavorite(String previewUrl) async {
    await _favoritesService.removeFavorite(previewUrl);
    _loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          _favorites.isEmpty
              ? Center(
                child: Text(
                  AppLocalizations.of(context).favoriteadd.toString(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              )
              : ListView.builder(
                itemCount: _favorites.length,
                itemBuilder: (context, index) {
                  final track = _favorites[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(track['albumCoverUrl']),
                    ),
                    title: Text(track['trackTitle']),
                    subtitle: Text(track['artistName']),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      onPressed: () => _removeFavorite(track['previewUrl']),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => MusicPlayerPage(
                                trackTitle: track['trackTitle'],
                                artistName: track['artistName'],
                                albumCoverUrl: track['albumCoverUrl'],
                                previewUrl: track['previewUrl'],
                              ),
                        ),
                      );
                    },
                  );
                },
              ),
    );
  }
}
