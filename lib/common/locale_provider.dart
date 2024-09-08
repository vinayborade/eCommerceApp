import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider with ChangeNotifier {
  Locale _locale = Locale("en");

  Locale get locale {
    SharedPreferences.getInstance().then((prefs) {
      // String _languageCode = prefs.getString(AuthPref.languageCode.toString());
      //if (_locale == null && _languageCode != null) {
      //etLocale(Locale("en"));
      // }
    });
    return _locale;
  }

  // void setLocale(Locale locale) {
  //   if (!L10n.all.contains(locale)) return;

  //   _locale = locale;
  //   notifyListeners();
  // }

  void clearLocale() {
    // _locale = null;
    notifyListeners();
  }
}
