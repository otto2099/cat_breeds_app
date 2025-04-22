import 'package:cat_breeds_app/core/models/breeds_models.dart';

abstract class LandingState {}

class LandingInitial extends LandingState {}

class LandingLoading extends LandingState {}

class LandingLoaded extends LandingState {
  final List<CatBreedModel> images;
  LandingLoaded({required this.images});
}

class LandingError extends LandingState {
  final String message;
  LandingError({required this.message});
}
