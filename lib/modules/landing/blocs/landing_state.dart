import 'package:cat_breeds_app/core/models/image_breeds_models.dart';

abstract class LandingState {}

class LandingInitial extends LandingState {}

class LandingLoading extends LandingState {}

class LandingLoaded extends LandingState {
  final List<BreedWithImageModel> images;
  LandingLoaded({required this.images});
}

class LandingError extends LandingState {
  final String message;
  LandingError({required this.message});
}
