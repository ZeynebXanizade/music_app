import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/src/cubit/post_list/post_list_cubit.dart';

class HomePageTopCardWidgets extends StatefulWidget {
  const HomePageTopCardWidgets({super.key});

  @override
  State<HomePageTopCardWidgets> createState() => _HomePageTopCardWidgetsState();
}

class _HomePageTopCardWidgetsState extends State<HomePageTopCardWidgets> {
  @override
  void initState() {
    super.initState();
    context.read<PostListCubit>().fetchAlbumDetails();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostListCubit, PostListState>(
      builder: (context, state) {
        if (state is PostListLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PostListLoaded) {
          final List<dynamic> tracks = state.albumData['tracks']['data'] ?? [];
          return SizedBox(
            height: 240,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: tracks.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final track = tracks[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 220,

                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(track['album']['cover_big']),
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.circular(45),
                    ),
                  ),
                );
                // return ListTile(
                //   title: Text(track['title']),
                //   subtitle: Text('Duration: ${track['duration']} seconds'),

                // );
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
        return const Center(child: Text("No data available."));
      },
    );
  }
}
