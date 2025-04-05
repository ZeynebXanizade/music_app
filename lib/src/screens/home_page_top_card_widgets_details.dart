import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentation/cubit/post_list/post_list_cubit.dart';
import 'music_player_page.dart';

class HomePageTopCardWidgetsDetails extends StatelessWidget {
  const HomePageTopCardWidgetsDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostListCubit, PostListState>(
      builder: (context, state) {
        if (state is PostListLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is PostListLoaded) {
          final List<dynamic>? tracks = state.albumData['tracks'];

          if (tracks == null || tracks.isEmpty) {
            return const Center(child: Text("Mahnılar tapılmadı."));
          }

          return Scaffold(
            appBar: AppBar(),
            body: SafeArea(
              child: ListView.builder(
                itemCount: tracks.length,
                itemBuilder: (context, index) {
                  final track = tracks[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => MusicPlayerPage(
                                trackTitle: track['title'],
                                artistName: track['artist']['name'],
                                albumCoverUrl: track['album']['cover_medium'],
                                previewUrl: track['preview'],
                              ),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: Image.network(track['album']['cover_small']),
                      title: Text(track['title']),
                      subtitle: Text(track['artist']['name']),
                    ),
                  );
                },
              ),
            ),
          );
        } else if (state is PostListError) {
          return Center(
            child: Text(
              state.errorMessage,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }
        return const Center(child: Text("Kateqoriya seçin."));
      },
    );
  }
}
