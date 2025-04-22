abstract class LandingEvent {}

class LoadCatImages extends LandingEvent {
  final int page;
  LoadCatImages({required this.page});
}
