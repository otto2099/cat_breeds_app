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

class AddSearchTerm extends LandingEvent {
  final String searchTerm;
  AddSearchTerm({required this.searchTerm});
}

class LoadSearchHistory extends LandingEvent {}

class ClearSearchHistory extends LandingEvent {}
