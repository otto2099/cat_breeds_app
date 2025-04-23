import 'package:bloc_test/bloc_test.dart';
import 'package:cat_breeds_app/core/models/image_breeds_models.dart';
import 'package:cat_breeds_app/core/models/weight_model.dart';
import 'package:cat_breeds_app/modules/landing/blocs/landing_bloc.dart';
import 'package:cat_breeds_app/modules/landing/blocs/landing_event.dart';
import 'package:cat_breeds_app/modules/landing/blocs/landing_state.dart';
import 'package:cat_breeds_app/core/models/breeds_models.dart';
import 'package:cat_breeds_app/modules/landing/ui/pages/landing_page.dart';
import 'package:cat_breeds_app/ui/widgets/animated_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockLandingBloc extends Mock implements LandingBloc {}

class FakeLandingEvent extends Fake implements LandingEvent {}

class FakeLandingState extends Fake implements LandingState {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeLandingEvent());
    registerFallbackValue(FakeLandingState());
  });

  late MockLandingBloc mockBloc;

  setUp(() {
    mockBloc = MockLandingBloc();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<LandingBloc>.value(
        value: mockBloc,
        child: const LandingScreen(),
      ),
    );
  }

  testWidgets('shows loading indicator when state is LandingLoading', (
    tester,
  ) async {
    when(() => mockBloc.state).thenReturn(LandingLoading());
    whenListen(mockBloc, Stream.value(LandingLoading()));

    await tester.pumpWidget(createWidgetUnderTest());
    expect(find.byType(AnimatedLogo), findsOneWidget);
  });

  testWidgets('shows breed list when state is LandingLoaded', (tester) async {
    final breeds = [
      CatBreedModel(
        id: 'abob',
        name: 'Bengal',
        weight: WeightModel(imperial: '7 - 16', metric: '3 - 7'),
        cfaUrl: '',
        vetstreetUrl: '',
        vcahospitalsUrl: '',
        temperament: '',
        origin: '',
        countryCodes: '',
        countryCode: '',
        description: '',
        lifeSpan: '11 - 15',
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
        wikipediaUrl: '',
        image: const BreedWithImageModel(
          id: 'img123',
          url: '',
          width: 800,
          height: 600,
        ),
      ),
    ];

    when(() => mockBloc.state).thenReturn(LandingLoaded(images: breeds));
    whenListen(mockBloc, Stream.value(LandingLoaded(images: breeds)));

    await tester.pumpWidget(createWidgetUnderTest());
    expect(find.text('Bengal'), findsOneWidget);
  });

  testWidgets(
    'typing in TextField dispatches SearchCatImages and AddSearchTerm after debounce',
    (tester) async {
      when(() => mockBloc.state).thenReturn(LandingLoaded(images: []));
      whenListen(mockBloc, Stream.value(LandingLoaded(images: [])));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.enterText(find.byType(TextField), 'bengal');
      await tester.pump(const Duration(seconds: 3)); // Esperar debounce

      verify(
        () => mockBloc.add(
          any(
            that: isA<SearchCatImages>().having(
              (e) => e.query,
              'query',
              'bengal',
            ),
          ),
        ),
      ).called(1);

      verify(
        () => mockBloc.add(
          any(
            that: isA<AddSearchTerm>().having(
              (e) => e.searchTerm,
              'searchTerm',
              'bengal',
            ),
          ),
        ),
      ).called(1);
    },
  );

  testWidgets('selecting search history term dispatches SearchCatImages', (
    tester,
  ) async {
    final searchTerms = ['siamese'];

    when(
      () => mockBloc.state,
    ).thenReturn(SearchHistoryLoaded(searchHistory: searchTerms));
    whenListen(
      mockBloc,
      Stream.value(SearchHistoryLoaded(searchHistory: searchTerms)),
    );

    await tester.pumpWidget(createWidgetUnderTest());

    await tester.tap(find.byType(TextField));
    await tester.pumpAndSettle();

    expect(find.text('siamese'), findsOneWidget);

    await tester.tap(find.text('siamese'));
    await tester.pump(const Duration(milliseconds: 500));

    verify(
      () => mockBloc.add(
        any(
          that: isA<SearchCatImages>().having(
            (e) => e.query,
            'query',
            'siamese',
          ),
        ),
      ),
    ).called(1);
  });

  testWidgets('shows error message when state is LandingError', (tester) async {
    when(
      () => mockBloc.state,
    ).thenReturn(LandingError(message: 'Something went wrong'));
    whenListen(
      mockBloc,
      Stream.value(LandingError(message: 'Something went wrong')),
    );

    await tester.pumpWidget(createWidgetUnderTest());
    expect(find.text('Something went wrong'), findsOneWidget);
  });
}
