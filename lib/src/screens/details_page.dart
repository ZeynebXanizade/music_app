import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/src/presentation/cubit/post_list/post_list_cubit.dart';
import 'package:audioplayers/audioplayers.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _HomePageTopCardWidgetsState();
}

class _HomePageTopCardWidgetsState extends State<DetailsPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _currentlyPlaying;

  @override
  void initState() {
    super.initState();
    // context.read<PostListCubit>().fetchSongsByCategory(category: 'Pop');
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostListCubit, PostListState>(
      builder: (context, state) {
        if (state is PostListLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PostListLoaded) {
          final List<dynamic> tracks = state.albumData['tracks']['data'] ?? [];
          return ListView.builder(
            itemCount: tracks.length,
            itemBuilder: (context, index) {
              final track = tracks[index];
              return ListTile(
                title: Text(track['title']),
                subtitle: Text('Duration: ${track['duration']} seconds'),
                trailing: IconButton(
                  icon: Icon(
                    _currentlyPlaying == track['title']
                        ? Icons.pause
                        : Icons.play_arrow,
                  ),
                  onPressed: () async {
                    if (_currentlyPlaying == track['title']) {
                      await _audioPlayer.pause();
                      setState(() {
                        _currentlyPlaying = null;
                      });
                    } else {
                      await _audioPlayer.play(UrlSource(track['preview']));
                      setState(() {
                        _currentlyPlaying = track['title'];
                      });
                    }
                  },
                ),
              );
            },
          );
        } else if (state is PostListError) {
          return Center(
            child: Text(
              state.errorMessage,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }
        return const Center(child: Text("No data available."));
      },
    );
  }
}
