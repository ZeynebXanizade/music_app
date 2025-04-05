import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/l10n/app_localizations.dart';

import '../presentation/cubit/post_list/post_list_cubit.dart';
import '../utils/constants/app_colors.dart';

class SearchBarWidgets extends StatelessWidget {
  const SearchBarWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        style: Theme.of(context).textTheme.titleMedium,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, color: secondaryGrey, size: 30),
          hintText: AppLocalizations.of(context).search.toString(),
          hintStyle: Theme.of(context).textTheme.titleMedium,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: (query) {
          if (query.isNotEmpty) {
            context.read<PostListCubit>().fetchSongsBySearch(query);
          } else {
            context.read<PostListCubit>().emit(PostListInitial());
          }
        },
      ),
    );
  }
}
