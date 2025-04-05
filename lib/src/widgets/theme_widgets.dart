import 'package:flutter/material.dart';
import 'package:music_app/l10n/app_localizations.dart';
import 'package:music_app/src/presentation/provider/theme_change.dart';
import 'package:provider/provider.dart';

class ThemeWidget extends StatelessWidget {
  const ThemeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final currentTheme = themeNotifier.themeMode;

    Widget buildThemeButton({
      required String label,
      required ThemeMode themeMode,
    }) {
      final isSelected = currentTheme == themeMode;
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isSelected
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.surface,
        ),
        onPressed: () {
          themeNotifier.setThemeMode(themeMode);
        },
        child: Text(label, style: Theme.of(context).textTheme.labelMedium),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Theme.of(context).colorScheme.primary,
        ),
        width: MediaQuery.of(context).size.width * 0.55,
        height: MediaQuery.of(context).size.height * 0.25,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.rotate(
              angle: 9.40 / 2,
              child: Text(
                AppLocalizations.of(context).theme,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildThemeButton(
                  label: AppLocalizations.of(context).light,
                  themeMode: ThemeMode.light,
                ),
                buildThemeButton(
                  label: AppLocalizations.of(context).dark,
                  themeMode: ThemeMode.dark,
                ),
                buildThemeButton(
                  label: AppLocalizations.of(context).system,
                  themeMode: ThemeMode.system,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
