import 'package:cat_breeds_app/core/routes/app_router.dart';
import 'package:cat_breeds_app/modules/landing/blocs/landing_bloc.dart';
import 'package:cat_breeds_app/modules/landing/services/breed_image_service.dart';
import 'package:cat_breeds_app/modules/landing/services/local_search_history_service.dart';
import 'package:cat_breeds_app/modules/landing/ui/pages/landing_page.dart';
import 'package:cat_breeds_app/modules/splash/blocs/splash_bloc.dart';
import 'package:cat_breeds_app/modules/splash/blocs/splash_event.dart';
import 'package:cat_breeds_app/modules/splash/services/landing_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SplashBloc(LandingService())..add(LoadBreedsEvent()),
          child: LandingScreen(),
        ),
        BlocProvider(
          create:
              (_) => LandingBloc(
                catImageService: BreedImageService(),
                localSearchHistoryService: LocalSearchHistoryService(),
              ),
          child: LandingScreen(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Catlas',
        themeMode: ThemeMode.system,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const <Locale>[Locale('es', 'CO')],
        routerConfig: AppRouter.router,
      ),
    );
  }
}
