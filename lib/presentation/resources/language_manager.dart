import 'dart:ui';

const String ar = "ar";
const String en = "en";

const String assetPathLocalization = "assets/translations";

const Locale arabicLocale = Locale('ar', 'SA');
const Locale englishLocale = Locale('en', 'US');

enum LanguageType {
  arabic(ar),
  english(en);

  final String getLang;
  const LanguageType(this.getLang);
}
