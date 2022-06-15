import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcircle_project_ui/helpers/en_us.dart';
import 'package:mcircle_project_ui/helpers/km_kh.dart';

class LocalizationService extends Translations {
  static final locale = Locale('en', 'US');

  static final fallbackLocale = Locale('km', 'KH');

  static final langs = [
    'English',
    'Khmer',
  ];

  static final locales = [
    Locale('en', 'US'),
    Locale('kh', 'KH'),
  ];

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUS,
        'km_KH': kmKh,
      };

  void changeLocale(String lang) {
    final locale = _getLocaleFromLanguage(lang);
    Get.updateLocale(locale);
  }

  _getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return Get.locale;
  }
}
