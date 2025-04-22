abstract class LandingEvent {}

class LoadCatImages extends LandingEvent {
  final int page;
  LoadCatImages({required this.page});
}

class SearchCatImages extends LandingEvent {
  final String query;
  final int page;

  SearchCatImages({required this.query, required this.page});
}
