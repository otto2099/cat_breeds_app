import 'package:cat_breeds_app/core/database/collections_name.dart';
import 'package:cat_breeds_app/modules/landing/services/local_search_history_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_test/hive_test.dart';

void main() {
  late LocalSearchHistoryService service;
  const boxName = Collections.searchHistory;

  setUp(() async {
    await setUpTestHive();

    if (!Hive.isBoxOpen(boxName)) {
      await Hive.openBox(boxName);
    }

    service = LocalSearchHistoryService();
  });

  tearDown(() async {
    if (Hive.isBoxOpen(boxName)) {
      final box = Hive.box(boxName);
      await box.clear();
    }

    await tearDownTestHive();
  });

  test('addSearchTerm adds new term to search history', () async {
    await service.addSearchTerm('persian');
    final result = await service.getSearchHistory();
    expect(result, ['persian']);
  });

  test('addSearchTerm avoids duplicates and reorders', () async {
    await service.addSearchTerm('bengal');
    await service.addSearchTerm('siamese');
    await service.addSearchTerm('bengal'); // debe quedar de primero

    final result = await service.getSearchHistory();
    expect(result, ['bengal', 'siamese']);
  });

  test('addSearchTerm limits history to 5 items', () async {
    for (var i = 0; i < 6; i++) {
      await service.addSearchTerm('cat_$i');
    }

    final result = await service.getSearchHistory();
    expect(result.length, 5);
    expect(result, ['cat_5', 'cat_4', 'cat_3', 'cat_2', 'cat_1']);
  });

  test('clearSearchHistory removes all items', () async {
    await service.addSearchTerm('sphynx');

    final beforeClear = await service.getSearchHistory();
    expect(beforeClear, isNotEmpty);

    await service.clearSearchHistory();

    final result = await service.getSearchHistory();
    expect(result, isNotEmpty);
  });

  test('addSearchTerm does not add empty strings', () async {
    await service.addSearchTerm('');
    final result = await service.getSearchHistory();
    expect(result, []);
  });
}
