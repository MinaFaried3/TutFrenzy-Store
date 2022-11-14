const String ar = "ar";
const String en = "en";

enum LanguageType {
  arabic(ar),
  english(en);

  final String getLang;
  const LanguageType(this.getLang);
}
