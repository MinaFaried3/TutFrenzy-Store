import 'package:equatable/equatable.dart';
import 'package:frenzy_store/presentation/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String languageKey = "language";
const String onBoardingViewedKey = "onBoardingViewed";
const String isUserLoggedIn = "userLoggedin";

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

  Future<bool> getOnBoardingScreenViewed() async {
    return _sharedPreferences.getBool(onBoardingViewedKey) ?? false;
  }

  //login
  Future<void> setUserLoggedIn() async {
    _sharedPreferences.setBool(isUserLoggedIn, true);
  }

  Future<bool> getUserLoggedIn() async {
    return _sharedPreferences.getBool(isUserLoggedIn) ?? false;
  }

  @override
  List<Object> get props => [_sharedPreferences];
}
