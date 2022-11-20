import 'package:flutter/material.dart';
import 'package:frenzy_store/app/dependency_injection.dart';

import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initAppModule();
  runApp(MyApp());
}
