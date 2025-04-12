import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../services/favorite_services.dart';

class MusicPlayerPage extends StatefulWidget {
  final String trackTitle;
  final String artistName;
  final String albumCoverUrl;
  final String previewUrl;

  const MusicPlayerPage({
    super.key,
    required this.trackTitle,
    required this.artistName,
    required this.albumCoverUrl,
    required this.previewUrl,
  });

  @override
  State<MusicPlayerPage> createState() => _MusicPlayerPageState();
}

class _MusicPlayerPageState extends State<MusicPlayerPage> {
  late AudioPlayer _player;
  bool _isPlaying = false;
  bool _isFavorite = false;

  final _favoritesService = FavoritesService();

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();

    _player.setUrl(widget.previewUrl).then((_) {
      _player.play();
      setState(() {
        _isPlaying = true;
      });
    });

    _player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        _player.seek(Duration.zero);
        _player.pause();
        setState(() {
          _isPlaying = false;
        });
      }
    });

    _loadFavoriteStatus();
  }

  void _loadFavoriteStatus() async {
    final isFav = await _favoritesService.isFavorite(widget.previewUrl);
    setState(() {
      _isFavorite = isFav;
    });
  }

  void _toggleFavorite() async {
    final track = {
      'trackTitle': widget.trackTitle,
      'artistName': widget.artistName,
      'albumCoverUrl': widget.albumCoverUrl,
      'previewUrl': widget.previewUrl,
    };

    if (_isFavorite) {
      await _favoritesService.removeFavorite(widget.previewUrl);
    } else {
      await _favoritesService.addFavorite(track);
    }

    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.trackTitle),
        actions: [
          IconButton(
            icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border),
            onPressed: _toggleFavorite,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(widget.albumCoverUrl, height: 250),
              ),
              const SizedBox(height: 20),
              Text(
                widget.trackTitle,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                widget.artistName,
                style: const TextStyle(fontSize: 18, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              StreamBuilder<Duration?>(
                stream: _player.durationStream,
                builder: (context, snapshot) {
                  final duration = snapshot.data ?? Duration.zero;
                  return StreamBuilder<Duration>(
                    stream: _player.positionStream,
                    builder: (context, snapshot) {
                      final position = snapshot.data ?? Duration.zero;
                      return Column(
                        children: [
                          Slider(
                            min: 0.0,
                            max: duration.inMilliseconds.toDouble(),
                            value:
                                position.inMilliseconds
                                    .clamp(0, duration.inMilliseconds)
                                    .toDouble(),
                            onChanged: (value) {
                              _player.seek(
                                Duration(milliseconds: value.toInt()),
                              );
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(_formatDuration(position)),
                              Text(_formatDuration(duration)),
                            ],
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 30),
              IconButton(
                iconSize: 64,
                icon: Icon(_isPlaying ? Icons.pause_circle : Icons.play_circle),
                onPressed: () {
                  if (_isPlaying) {
                    _player.pause();
                  } else {
                    _player.play();
                  }
                  setState(() {
                    _isPlaying = !_isPlaying;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
