import 'package:flutter/material.dart';
import 'package:frenzy_store/presentation/resources/routes_manager.dart';

import '../presentation/resources/themes_manager.dart';

class MyApp extends StatefulWidget {
  const MyApp._internal({Key? key}) : super(key: key);

  static const MyApp _singletonInstance = MyApp._internal();

  factory MyApp() => _singletonInstance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: getApplicationTheme(),
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
    );
  }
}
