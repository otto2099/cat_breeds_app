import 'package:cat_breeds_app/core/models/breeds_models.dart';
import 'package:equatable/equatable.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashLoaded extends SplashState {
  final List<CatBreedModel> breeds;

  const SplashLoaded(this.breeds);

  @override
  List<Object> get props => [breeds];
}

class SplashError extends SplashState {
  final String message;

  const SplashError(this.message);

  @override
  List<Object> get props => [message];
}
