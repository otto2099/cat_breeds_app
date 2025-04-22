import 'package:cat_breeds_app/app.dart';
import 'package:cat_breeds_app/env/env.dart';
import 'package:cat_breeds_app/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  sl.registerLazySingleton(() => Env(EnvMode.dev));
  await dotenv.load(fileName: Env.fileName);
  runApp(const App());
}
