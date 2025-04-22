import 'package:cat_breeds_app/core/database/collections_name.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await Hive.initFlutter();

  // Open Box
  await Hive.openBox(Collections.searchHistory);
}
