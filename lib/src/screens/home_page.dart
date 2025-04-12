import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/l10n/app_localizations.dart';
import 'package:music_app/src/widgets/home_page_bottom_card_widgets.dart';
import 'package:music_app/src/widgets/home_page_top_card_widgets.dart';
import 'package:music_app/src/widgets/search_bar_widgets.dart';

import '../presentation/cubit/post_list/post_list_cubit.dart';
import 'music_player_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchBarWidgets(),
              const SizedBox(height: 30),
              Expanded(
                child: BlocBuilder<PostListCubit, PostListState>(
                  builder: (context, state) {
                    if (state is PostListLoaded &&
                        state.searchResults.isNotEmpty) {
                      return ListView.builder(
                        itemCount: state.searchResults.length,
                        itemBuilder: (context, index) {
                          final track = state.searchResults[index];
                          return ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => MusicPlayerPage(
                                        trackTitle: track['title'],
                                        artistName: track['artist']['name'],
                                        albumCoverUrl:
                                            track['album']['cover_medium'],
                                        previewUrl: track['preview'],
                                      ),
                                ),
                              );
                            },
                            leading: Image.network(
                              track['album']['cover_medium'],
                              errorBuilder:
                                  (context, error, stackTrace) =>
                                      const Icon(Icons.image_not_supported),
                            ),
                            title: Text(track['title']),
                            subtitle: Text(track['artist']['name']),
                          );
                        },
                      );
                    }

                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HomePageTopCardWidgets(),
                          const SizedBox(height: 30),
                          Text(
                            AppLocalizations.of(context).famoussongs,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 30),
                          HomePageBottomCardWidgets(),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
