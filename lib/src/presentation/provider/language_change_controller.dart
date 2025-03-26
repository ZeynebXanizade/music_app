import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguage extends ChangeNotifier {
  Locale? _appLocale;
  Locale? get appLocal => _appLocale;

  fetchLocale() async {
    var pref = await SharedPreferences.getInstance();
    if (pref.getString('language_code') == null) {
      _appLocale = const Locale('en');
      return null;
    }
    String local = pref.getString('language_code') ?? 'en';
    _appLocale = Locale(local.toString());
    return null;
  }

  void changeLanguage(Locale type) async {
    var pref = await SharedPreferences.getInstance();
    if (_appLocale == type) {
      return;
    }
    if (type == const Locale('az')) {
      print(type);
      _appLocale = const Locale('az');
      await pref.setString('language_code', 'az');
    } else if (type == const Locale('ru')) {
      print(type);
      _appLocale = const Locale('ru');
      await pref.setString('language_code', 'ru');
    } else if (type == const Locale('en')) {
      _appLocale = const Locale('en');
      await pref.setString('language_code', 'en');
    } else {
      return;
    }
    notifyListeners();
  }
}
