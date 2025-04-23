import 'package:flutter_test/flutter_test.dart';
import 'package:cat_breeds_app/modules/landing/blocs/landing_state.dart';
import 'package:cat_breeds_app/core/models/breeds_models.dart';
import 'package:cat_breeds_app/core/models/image_breeds_models.dart';
import 'package:cat_breeds_app/core/models/weight_model.dart';

void main() {
  group('LandingState Tests', () {
    test('LandingInitial is a LandingState', () {
      final state = LandingInitial();
      expect(state, isA<LandingState>());
    });

    test('LandingLoading is a LandingState', () {
      final state = LandingLoading();
      expect(state, isA<LandingState>());
    });

    test('LandingLoaded contains list of CatBreedModel', () {
      final mockBreed = CatBreedModel(
        id: 'abob',
        name: 'American Bobtail',
        weight: WeightModel(imperial: '7 - 16', metric: '3 - 7'),
        cfaUrl: 'url1',
        vetstreetUrl: 'url2',
        vcahospitalsUrl: 'url3',
        temperament: 'Temperament',
        origin: 'USA',
        countryCodes: 'US',
        countryCode: 'US',
        description: 'Description',
        lifeSpan: '10 - 15',
        indoor: 0,
        lap: 1,
        altNames: '',
        adaptability: 5,
        affectionLevel: 5,
        childFriendly: 4,
        dogFriendly: 4,
        energyLevel: 3,
        grooming: 2,
        healthIssues: 1,
        intelligence: 5,
        sheddingLevel: 2,
        socialNeeds: 4,
        strangerFriendly: 3,
        wikipediaUrl: 'wiki',
        image: const BreedWithImageModel(
          id: 'img123',
          url: 'https://cdn2.thecatapi.com/images/xyz.jpg',
          width: 800,
          height: 600,
        ),
      );

      final state = LandingLoaded(images: [mockBreed]);
      expect(state.images, isA<List<CatBreedModel>>());
      expect(state.images.length, 1);
      expect(state.images.first.name, 'American Bobtail');
    });

    test('LandingError contains error message', () {
      final state = LandingError(message: 'Error occurred');
      expect(state.message, 'Error occurred');
    });

    test('SearchHistoryLoaded contains list of search terms', () {
      final state = SearchHistoryLoaded(searchHistory: ['persian', 'siamese']);
      expect(state.searchHistory, contains('persian'));
      expect(state.searchHistory.length, 2);
    });
  });
}
