import 'package:bloc/bloc.dart';
import 'package:cat_breeds_app/core/models/breeds_models.dart';
import 'package:cat_breeds_app/modules/landing/blocs/landing_event.dart';
import 'package:cat_breeds_app/modules/landing/blocs/landing_state.dart';
import 'package:cat_breeds_app/modules/landing/services/breed_image_service.dart';

class LandingBloc extends Bloc<LandingEvent, LandingState> {
  final BreedImageService catImageService;
  int currentPage = 0;
  bool isLoading = false;

  LandingBloc({required this.catImageService}) : super(LandingInitial()) {
    on<LoadCatImages>(_onLoadCatImages);
    on<SearchCatImages>(_onSearchCatImages);
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
              ? List<CatBreedModel>.from((state as LandingLoaded).images)
              : <CatBreedModel>[];

      final newImages = await catImageService.getCatImages(currentPage);
      currentPage++;

      emit(LandingLoaded(images: currentList + newImages));
    } catch (e) {
      emit(LandingError(message: 'Error al cargar imágenes'));
    } finally {
      isLoading = false;
    }
  }

  Future<void> _onSearchCatImages(
    SearchCatImages event,
    Emitter<LandingState> emit,
  ) async {
    if (isLoading) return;

    isLoading = true;

    try {
      final searchResults = await catImageService.searchBreeds(
        event.page,
        event.query,
      );

      emit(
        LandingLoaded(images: searchResults),
      ); // Solo muestra los resultados de la búsqueda
    } catch (e) {
      emit(LandingError(message: 'Error al buscar imágenes'));
    } finally {
      isLoading = false;
    }
  }
}
