import 'package:cat_breeds_app/modules/splash/blocs/splash_bloc.dart';
import 'package:cat_breeds_app/modules/splash/blocs/splash_event.dart';
import 'package:cat_breeds_app/modules/splash/blocs/splash_state.dart';
import 'package:cat_breeds_app/modules/splash/services/landing_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashBloc(LandingService())..add(LoadBreedsEvent()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashLoaded) {
            Future.delayed(const Duration(seconds: 2), () {
              if (context.mounted) {
                context.go('/landing');
              }
            });
          } else if (state is SplashError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0.0, end: 1.0),
                  duration: Duration(seconds: 2),
                  builder: (context, value, child) {
                    return Transform.scale(scale: value, child: child);
                  },
                  child: Image.asset(
                    'assets/logo_thecatapi.png',
                    width: 200,
                    height: 200,
                  ),
                ),
                const SizedBox(height: 24),
                BlocBuilder<SplashBloc, SplashState>(
                  builder: (context, state) {
                    if (state is SplashLoading || state is SplashInitial) {
                      return Text(
                        'Bienvenido a Catbreeds',
                        style: Theme.of(context).textTheme.headlineMedium,
                      );
                    } else {
                      return Text(
                        'Bienvenido a Catbreeds',
                        style: Theme.of(context).textTheme.headlineMedium,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
