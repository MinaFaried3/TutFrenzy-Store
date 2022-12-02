import 'package:flutter/foundation.dart';

class Constants {
  static const String baseUrl = 'https://tutfrenzy.mocklab.io';
  static const String empty = '';
  static const String token = "your token here";

  static const int zero = 0;
  static const int timeOut = 60000;
}

void printK(String string) {
  if (kDebugMode) {
    print(string);
  }
}
