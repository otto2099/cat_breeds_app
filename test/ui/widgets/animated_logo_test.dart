// test/ui/widgets/animated_logo_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cat_breeds_app/ui/widgets/animated_logo.dart';

void main() {
  group('AnimatedLogo', () {
    testWidgets('debe renderizar la imagen correctamente', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: AnimatedLogo())),
      );

      expect(find.byType(Image), findsOneWidget);
      expect(find.byKey(const Key('animated_logo_transform')), findsOneWidget);
    });
  });
}
