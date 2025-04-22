import 'package:bloc/bloc.dart';
import 'package:cat_breeds_app/modules/splash/blocs/splash_event.dart';
import 'package:cat_breeds_app/modules/splash/blocs/splash_state.dart';
import 'package:cat_breeds_app/core/models/breeds_models.dart';
import 'package:cat_breeds_app/modules/splash/services/landing_service.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final LandingService landingService;

  SplashBloc(this.landingService) : super(SplashInitial()) {
    on<LoadBreedsEvent>((event, emit) async {
      emit(SplashLoading());
      try {
        final List<CatBreedModel> breeds = await landingService.getBreeds();
        emit(SplashLoaded(breeds));
      } catch (e) {
        emit(SplashError("Error al cargar razas"));
      }
    });
  }
}
