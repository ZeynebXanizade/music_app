import 'package:flutter/material.dart';
import 'package:music_app/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../presentation/provider/language_change_controller.dart';

enum Language { english, azerbaijani, russian }

class AppLanguages extends StatefulWidget {
  const AppLanguages({super.key});

  @override
  State<AppLanguages> createState() => _AppLanguagesState();
}

bool status = false;
Language? selectedMenu;

class _AppLanguagesState extends State<AppLanguages> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppLanguage>(
      builder:
          (context, provider, child) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.translate,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            AppLocalizations.of(context).applanguage.toString(),
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                      ],
                    ),
                    PopupMenuButton<Language>(
                      color: Theme.of(context).popupMenuTheme.color,
                      initialValue: selectedMenu,
                      onSelected: (Language item) {
                        if (Language.english.name == item.name) {
                          provider.changeLanguage(const Locale('en'));
                        } else if (Language.azerbaijani.name == item.name) {
                          provider.changeLanguage(const Locale('az'));
                        } else if (Language.russian.name == item.name) {
                          provider.changeLanguage(const Locale('ru'));
                        }
                      },
                      itemBuilder:
                          (BuildContext context) => <PopupMenuEntry<Language>>[
                            PopupMenuItem<Language>(
                              onTap: () {
                                provider.changeLanguage(const Locale('az'));
                              },
                              value: Language.azerbaijani,
                              child: Text(
                                AppLocalizations.of(context).az.toString(),
                                style:
                                    Theme.of(context).popupMenuTheme.textStyle,
                              ),
                            ),
                            PopupMenuItem<Language>(
                              onTap: () {
                                provider.changeLanguage(const Locale('en'));
                              },
                              value: Language.english,
                              child: Text(
                                AppLocalizations.of(context).en.toString(),
                                style:
                                    Theme.of(context).popupMenuTheme.textStyle,
                              ),
                            ),
                            PopupMenuItem<Language>(
                              onTap: () {
                                provider.changeLanguage(const Locale('ru'));
                              },
                              value: Language.russian,
                              child: Text(
                                AppLocalizations.of(context).ru.toString(),
                                style:
                                    Theme.of(context).popupMenuTheme.textStyle,
                              ),
                            ),
                          ],
                    ),
                  ],
                ),
              ],
            ),
          ),
    );
  }
}
