import 'package:equatable/equatable.dart';
import 'package:frenzy_store/presentation/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String languageKey = "language";
const String onBoardingViewedKey = "onBoardingViewed";
const String isUserLoggedInKey = "userLoggedIn";

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

  //onBoarding
  Future<void> setOnBoardingScreenViewed() async {
    _sharedPreferences.setBool(onBoardingViewedKey, true);
  }

  Future<bool> isOnBoardingScreenViewed() async {
    // if key null return false
    return _sharedPreferences.getBool(onBoardingViewedKey) ?? false;
  }

  //login
  Future<void> setUserLoggedIn() async {
    _sharedPreferences.setBool(isUserLoggedInKey, true);
  }

  Future<bool> isUserLoggedIn() async {
    return _sharedPreferences.getBool(isUserLoggedInKey) ?? false;
  }

  @override
  List<Object> get props => [_sharedPreferences];
}
