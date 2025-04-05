import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/l10n/app_localizations.dart';
import 'package:music_app/src/config/themes.dart';
import 'package:music_app/src/presentation/provider/language_change_controller.dart';
import 'package:music_app/src/presentation/provider/theme_change.dart';
import 'package:music_app/src/widgets/bottom_navigation_bar_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'src/presentation/cubit/post_list/post_list_cubit.dart';

AppLanguage appLanguage = AppLanguage();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  final pref = await SharedPreferences.getInstance();
  final String languageCode = pref.getString('language_code') ?? '';

  runApp(MyApp(locale: languageCode));
}

class MyApp extends StatelessWidget {
  final String locale;
  const MyApp({super.key, required this.locale});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeNotifier>(create: (_) => ThemeNotifier()),
        ChangeNotifierProvider<AppLanguage>(create: (_) => AppLanguage()),
        BlocProvider<PostListCubit>(create: (_) => PostListCubit(Dio())),
      ],
      child: Consumer<AppLanguage>(
        builder: (context, provider, child) {
          if (provider.appLocal == null) {
            provider.fetchLocale();
            if (locale.isEmpty) {
              provider.changeLanguage(const Locale('en'));
            } else {
              provider.changeLanguage(Locale(locale));
            }
          }

          return MaterialApp(
            home: BottomNavigationBarWidget(),
            debugShowCheckedModeBanner: false,
            theme: ThemesApp.lightTheme,
            darkTheme: ThemesApp.darkTheme,
            themeMode: Provider.of<ThemeNotifier>(context).themeMode,
            locale:
                locale == ''
                    ? const Locale('en')
                    : provider.appLocal == null
                    ? Locale(locale)
                    : Provider.of<AppLanguage>(context).appLocal,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale("az"), Locale("en"), Locale("ru")],
          );
        },
      ),
    );
  }
}
