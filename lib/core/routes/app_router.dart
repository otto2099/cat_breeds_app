import 'package:cat_breeds_app/modules/detail/ui/pages/detail_screen.dart';
import 'package:cat_breeds_app/modules/landing/ui/pages/landing_page.dart';
import 'package:cat_breeds_app/modules/splash/ui/pages/splash_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/landing',
        name: 'landing',
        builder: (context, state) => LandingScreen(),
      ),
      GoRoute(
        path: '/detail/:id',
        name: 'breed_detail',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return BreedDetailScreen(breedId: id);
        },
      ),
    ],
  );
}
