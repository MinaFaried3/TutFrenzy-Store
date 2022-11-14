import 'package:equatable/equatable.dart';
import 'package:frenzy_store/presentation/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String languageKey = "language";

class AppPreferences extends Equatable {
  final SharedPreferences _sharedPreferences;

  const AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    final String? language = _sharedPreferences.getString(languageKey);

    if (language != null && language != '') {
      return language;
    } else {
      // return default language
      return LanguageType.english.getLang;
    }
  }

  @override
  List<Object> get props => [_sharedPreferences];
}
