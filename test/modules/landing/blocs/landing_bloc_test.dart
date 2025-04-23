import 'package:bloc_test/bloc_test.dart';
import 'package:cat_breeds_app/core/models/breeds_models.dart';
import 'package:cat_breeds_app/core/models/image_breeds_models.dart';
import 'package:cat_breeds_app/core/models/weight_model.dart';
import 'package:cat_breeds_app/modules/landing/blocs/landing_bloc.dart';
import 'package:cat_breeds_app/modules/landing/blocs/landing_event.dart';
import 'package:cat_breeds_app/modules/landing/blocs/landing_state.dart';
import 'package:cat_breeds_app/modules/landing/services/breed_image_service.dart';
import 'package:cat_breeds_app/modules/landing/services/local_search_history_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBreedImageService extends Mock implements BreedImageService {}

class MockLocalSearchHistoryService extends Mock
    implements LocalSearchHistoryService {}

void main() {
  late MockBreedImageService mockBreedImageService;
  late MockLocalSearchHistoryService mockLocalSearchHistoryService;
  late CatBreedModel mockBreed;

  setUp(() {
    mockBreedImageService = MockBreedImageService();
    mockLocalSearchHistoryService = MockLocalSearchHistoryService();
    mockBreed = CatBreedModel(
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
  });

  blocTest<LandingBloc, LandingState>(
    'emits [LandingLoaded] when LoadCatImages is added',
    build: () {
      when(
        () => mockBreedImageService.getCatImages(any()),
      ).thenAnswer((_) async => [mockBreed]);
      return LandingBloc(
        catImageService: mockBreedImageService,
        localSearchHistoryService: mockLocalSearchHistoryService,
      );
    },
    act: (bloc) => bloc.add(LoadCatImages(page: 0)),
    expect: () => [isA<LandingLoaded>()],
  );

  blocTest<LandingBloc, LandingState>(
    'emits [LandingLoaded] when SearchCatImages is added',
    build: () {
      when(
        () => mockBreedImageService.searchBreeds(any(), any()),
      ).thenAnswer((_) async => [mockBreed]);
      return LandingBloc(
        catImageService: mockBreedImageService,
        localSearchHistoryService: mockLocalSearchHistoryService,
      );
    },
    act: (bloc) => bloc.add(SearchCatImages(query: 'bobtail', page: 1)),
    expect: () => [isA<LandingLoaded>()],
  );

  blocTest<LandingBloc, LandingState>(
    'emits [SearchHistoryLoaded] when LoadSearchHistory is added',
    build: () {
      when(
        () => mockLocalSearchHistoryService.getSearchHistory(),
      ).thenAnswer((_) async => ['bobtail']);
      return LandingBloc(
        catImageService: mockBreedImageService,
        localSearchHistoryService: mockLocalSearchHistoryService,
      );
    },
    act: (bloc) => bloc.add(LoadSearchHistory()),
    expect: () => [isA<SearchHistoryLoaded>()],
  );

  blocTest<LandingBloc, LandingState>(
    'emits [SearchHistoryLoaded] after AddSearchTerm',
    build: () {
      when(
        () => mockLocalSearchHistoryService.addSearchTerm(any()),
      ).thenAnswer((_) async {});
      when(
        () => mockLocalSearchHistoryService.getSearchHistory(),
      ).thenAnswer((_) async => ['persian']);
      return LandingBloc(
        catImageService: mockBreedImageService,
        localSearchHistoryService: mockLocalSearchHistoryService,
      );
    },
    act: (bloc) => bloc.add(AddSearchTerm(searchTerm: 'persian')),
    expect: () => [isA<SearchHistoryLoaded>()],
  );

  blocTest<LandingBloc, LandingState>(
    'emits [SearchHistoryLoaded] when ClearSearchHistory is added',
    build: () {
      when(
        () => mockLocalSearchHistoryService.clearSearchHistory(),
      ).thenAnswer((_) async {});
      return LandingBloc(
        catImageService: mockBreedImageService,
        localSearchHistoryService: mockLocalSearchHistoryService,
      );
    },
    act: (bloc) => bloc.add(ClearSearchHistory()),
    expect: () => [isA<SearchHistoryLoaded>()],
  );
}
