import 'package:bloc/bloc.dart';
import 'package:cat_breeds_app/core/models/image_breeds_models.dart';
import 'package:cat_breeds_app/modules/landing/blocs/landing_event.dart';
import 'package:cat_breeds_app/modules/landing/blocs/landing_state.dart';
import 'package:cat_breeds_app/modules/landing/services/breed_image_service.dart';

class LandingBloc extends Bloc<LandingEvent, LandingState> {
  final BreedImageService catImageService;
  int currentPage = 0;
  bool isLoading = false;

  LandingBloc({required this.catImageService}) : super(LandingInitial()) {
    on<LoadCatImages>(_onLoadCatImages);
  }

  Future<void> _onLoadCatImages(
    LoadCatImages event,
    Emitter<LandingState> emit,
  ) async {
    if (isLoading) return;

    isLoading = true;

    try {
      final currentList =
          state is LandingLoaded
              ? List<BreedWithImageModel>.from((state as LandingLoaded).images)
              : <BreedWithImageModel>[];

      final newImages = await catImageService.getCatImages(currentPage);
      currentPage++;

      emit(LandingLoaded(images: currentList + newImages));
    } catch (e) {
      emit(LandingError(message: 'Error al cargar imágenes'));
    } finally {
      isLoading = false;
    }
  }
}
