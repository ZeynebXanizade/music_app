import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentation/cubit/post_list/post_list_cubit.dart';
import '../screens/music_player_page.dart';

class HomePageBottomCardWidgets extends StatelessWidget {
  const HomePageBottomCardWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostListCubit, PostListState>(
      builder: (context, state) {
        if (state is PostListLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PostListLoaded) {
          final List<dynamic>? tracks = state.albumData['tracks'];

          if (tracks == null || tracks.isEmpty) {
            return const Center(child: Text("Mahnılar tapılmadı."));
          }

          return SizedBox(
            height: 300,
            child: ListView.builder(
              itemCount: tracks.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final track = tracks[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 160,
                          height: 160,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(track['album']['cover_big']),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(45),
                          ),
                        ),
                        const SizedBox(height: 8),

                        Text(
                          track['artist']['name'],
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          track['title'],
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                );
              },
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
