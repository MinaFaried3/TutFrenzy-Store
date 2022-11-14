import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:frenzy_store/app/app_prefs.dart';
import 'package:frenzy_store/app/constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String applicationJson = "application/json";
const String contentType = "content-type";
const String accept = "accept";
const String authorization = "authorization";
const String defaultLanguage = "Language";

class DioFactory extends Equatable {
  final AppPreferences _appPreferences;

  const DioFactory(this._appPreferences);

  Future<String> getLanguage() async {
    return await _appPreferences.getAppLanguage();
  }

  Future<Dio> getDio() async {
    final Dio dio = Dio();

    Map<String, String> headers = {
      contentType: applicationJson,
      accept: applicationJson,
      authorization: Constants.token,
      defaultLanguage: await getLanguage(),
    };

    dio.options = BaseOptions(
      baseUrl: Constants.baseUrl,
      headers: headers,
      sendTimeout: Constants.timeOut,
      receiveTimeout: Constants.timeOut,
    );

    if (kDebugMode) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }

    return dio;
  }

  @override
  List<Object> get props => [_appPreferences];
}
