import 'package:bloc/bloc.dart';
import 'package:cat_breeds_app/core/models/breeds_models.dart';
import 'package:cat_breeds_app/modules/landing/blocs/landing_event.dart';
import 'package:cat_breeds_app/modules/landing/blocs/landing_state.dart';
import 'package:cat_breeds_app/modules/landing/services/breed_image_service.dart';
import 'package:cat_breeds_app/modules/landing/services/local_search_history_service.dart';

class LandingBloc extends Bloc<LandingEvent, LandingState> {
  final BreedImageService catImageService;
  final LocalSearchHistoryService localSearchHistoryService;
  int currentPage = 0;
  bool isLoading = false;

  LandingBloc({
    required this.catImageService,
    required this.localSearchHistoryService,
  }) : super(LandingInitial()) {
    on<LoadCatImages>(_onLoadCatImages);
    on<SearchCatImages>(_onSearchCatImages);
    on<AddSearchTerm>(_onAddSearchTerm);
    on<LoadSearchHistory>(_onLoadSearchHistory);
    on<ClearSearchHistory>(_onClearSearchHistory);
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

      emit(LandingLoaded(images: searchResults));
    } catch (e) {
      emit(LandingError(message: 'Error al buscar imágenes'));
    } finally {
      isLoading = false;
    }
  }

  // Cargar historial de búsqueda
  Future<void> _onLoadSearchHistory(
    LoadSearchHistory event,
    Emitter<LandingState> emit,
  ) async {
    try {
      final searchHistory = await localSearchHistoryService.getSearchHistory();
      emit(SearchHistoryLoaded(searchHistory: searchHistory));
    } catch (e) {
      emit(LandingError(message: 'Error al cargar el historial de búsqueda'));
    }
  }

  Future<void> _onAddSearchTerm(
    AddSearchTerm event,
    Emitter<LandingState> emit,
  ) async {
    try {
      await localSearchHistoryService.addSearchTerm(event.searchTerm);
      final searchHistory = await localSearchHistoryService.getSearchHistory();
      emit(SearchHistoryLoaded(searchHistory: searchHistory));
    } catch (e) {
      emit(LandingError(message: 'Error al agregar el término de búsqueda'));
    }
  }

  Future<void> _onClearSearchHistory(
    ClearSearchHistory event,
    Emitter<LandingState> emit,
  ) async {
    await localSearchHistoryService.clearSearchHistory();
    emit(SearchHistoryLoaded(searchHistory: []));
  }
}
