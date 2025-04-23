import 'dart:io';

import 'package:cat_breeds_app/core/models/breeds_models.dart';
import 'package:cat_breeds_app/core/models/image_breeds_models.dart';
import 'package:cat_breeds_app/core/models/weight_model.dart';
import 'package:cat_breeds_app/modules/detail/ui/pages/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

class TestHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (_, __, ___) => true;
  }
}

void main() {
  setUpAll(() {
    HttpOverrides.global = TestHttpOverrides();
  });

  testWidgets('BreedDetailScreen displays breed data correctly', (
    WidgetTester tester,
  ) async {
    final mockBreed = CatBreedModel(
      id: 'abob',
      name: 'American Bobtail',
      weight: WeightModel(imperial: '7 - 16', metric: '3 - 7'),
      cfaUrl: 'https://cfa.org/AmericanBobtail',
      vetstreetUrl: 'https://vetstreet.com/AmericanBobtail',
      vcahospitalsUrl: 'https://vcahospitals.com/AmericanBobtail',
      temperament: 'Playful, Smart',
      origin: 'United States',
      countryCodes: 'US',
      countryCode: 'US',
      description: 'Very intelligent and affectionate cat.',
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
      wikipediaUrl: 'https://en.wikipedia.org/wiki/American_Bobtail',
      image: const BreedWithImageModel(
        id: 'img123',
        url: 'https://cdn2.thecatapi.com/images/xyz.jpg',
        width: 800,
        height: 600,
      ),
    );

    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: GoRouter(
          initialLocation: '/',
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => BreedDetailScreen(breed: mockBreed),
            ),
          ],
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('American Bobtail'), findsNWidgets(2));
    expect(find.text('Very intelligent and affectionate cat.'), findsOneWidget);
    expect(find.textContaining('Origen: United States'), findsOneWidget);
    expect(
      find.textContaining('Esperanza de vida: 11 - 15 años'),
      findsOneWidget,
    );
    expect(find.byType(Image), findsOneWidget);
    expect(find.text('Wikipedia'), findsOneWidget);
    expect(find.text('CFA'), findsOneWidget);
    expect(find.text('Vetstreet'), findsOneWidget);
  });
}
