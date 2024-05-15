class SearchEvent {}

class Search extends SearchEvent {
  final String keyword;

  Search({required this.keyword});
}

class ClearSearch extends SearchEvent {}
