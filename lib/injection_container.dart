import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Use cases

  /*-------------------------------
    DATA SOURCE
  -------------------------------*/

  // External BD
  await Hive.initFlutter();

  // Open Box
}
