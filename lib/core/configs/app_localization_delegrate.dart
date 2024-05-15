import 'package:lexa/core/configs/app_localization.dart';
import 'package:flutter/material.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'vi'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    AppLocalizations localizations = AppLocalizations(locale);
    return localizations.load().then((bool _) {
      return localizations;
    });
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
