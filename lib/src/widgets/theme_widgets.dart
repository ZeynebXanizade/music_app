import 'package:flutter/material.dart';
import 'package:music_app/l10n/app_localizations.dart';
import 'package:music_app/src/presentation/provider/theme_change.dart';
import 'package:provider/provider.dart';

class ThemeWidget extends StatelessWidget {
  const ThemeWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
                AppLocalizations.of(context).theme.toString(),
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Provider.of<ThemeNotifier>(
                      context,
                      listen: false,
                    ).setThemeMode(ThemeMode.light);
                  },
                  child: Text(
                    AppLocalizations.of(context).light.toString(),
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Provider.of<ThemeNotifier>(
                      context,
                      listen: false,
                    ).setThemeMode(ThemeMode.dark);
                  },
                  child: Text(
                    AppLocalizations.of(context).dark.toString(),
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Provider.of<ThemeNotifier>(
                      context,
                      listen: false,
                    ).setThemeMode(ThemeMode.system);
                  },
                  child: Text(
                    AppLocalizations.of(context).system.toString(),
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
