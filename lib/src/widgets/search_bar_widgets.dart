import 'package:flutter/material.dart';

import 'package:music_app/l10n/app_localizations.dart';

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
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, color: secondaryGrey, size: 30),
          hintText: AppLocalizations.of(context).search.toString(),
          hintStyle: Theme.of(context).textTheme.titleMedium,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
