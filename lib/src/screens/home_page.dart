import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/l10n/app_localizations.dart';
import 'package:music_app/src/widgets/home_page_bottom_card_widgets.dart';
import 'package:music_app/src/widgets/home_page_top_card_widgets.dart';
import 'package:music_app/src/widgets/search_bar_widgets.dart';

import '../presentation/cubit/post_list/post_list_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            leading: Image.network(
                              track['album']['cover_medium'],
                            ),
                            title: Text(track['title']),
                            subtitle: Text(track['artist']['name']),
                          );
                        },
                      );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(child: HomePageTopCardWidgets()),
                        const SizedBox(height: 30),
                        Text(
                          AppLocalizations.of(context).famoussongs,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 30),
                        Flexible(child: HomePageBottomCardWidgets()),
                      ],
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
