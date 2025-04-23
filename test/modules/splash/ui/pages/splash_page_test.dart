import 'package:cat_breeds_app/modules/splash/ui/pages/splash_page.dart';
import 'package:cat_breeds_app/ui/widgets/animated_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets('SplashScreen muestra el logo y texto correctamente', (
    tester,
  ) async {
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(path: '/', builder: (_, __) => const SplashScreen()),
        GoRoute(
          path: '/landing',
          builder: (_, __) => const Placeholder(key: Key('landing_screen')),
        ),
      ],
    );

    await tester.pumpWidget(MaterialApp.router(routerConfig: router));

    expect(find.byType(AnimatedLogo), findsOneWidget);
    expect(find.text('Bienvenido a Catbreeds'), findsOneWidget);

    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('landing_screen')), findsOneWidget);
  });

  testWidgets('SplashScreen navega a /landing después de 2 segundos', (
    tester,
  ) async {
    // Manejador de navegación falso
    final goRouter = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(path: '/', builder: (_, __) => const SplashScreen()),
        GoRoute(
          path: '/landing',
          builder: (_, __) => const Placeholder(key: Key('landing_screen')),
        ),
      ],
    );

    await tester.pumpWidget(MaterialApp.router(routerConfig: goRouter));

    expect(find.byType(SplashScreen), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('landing_screen')), findsOneWidget);
  });
}
