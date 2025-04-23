import 'package:flutter_test/flutter_test.dart';
import 'package:cat_breeds_app/modules/landing/blocs/landing_event.dart';

void main() {
  group('LandingEvent Tests', () {
    test('LoadCatImages stores correct page number', () {
      final event = LoadCatImages(page: 3);
      expect(event.page, 3);
      expect(event, isA<LandingEvent>());
    });

    test('SearchCatImages stores query and page correctly', () {
      final event = SearchCatImages(query: 'siamese', page: 1);
      expect(event.query, 'siamese');
      expect(event.page, 1);
    });

    test('AddSearchTerm stores the search term', () {
      final event = AddSearchTerm(searchTerm: 'persian');
      expect(event.searchTerm, 'persian');
    });

    test('LoadSearchHistory is a LandingEvent', () {
      final event = LoadSearchHistory();
      expect(event, isA<LandingEvent>());
    });

    test('ClearSearchHistory is a LandingEvent', () {
      final event = ClearSearchHistory();
      expect(event, isA<LandingEvent>());
    });
  });
}
