class SearchState {
  final List<dynamic> searchHistory;
  final List<dynamic>? searchResult;
  final bool isLoading;

  SearchState({
    this.searchHistory = const [],
    this.searchResult,
    this.isLoading = false,
  });

  SearchState copyWith({List<dynamic>? searchHistory, List<dynamic>? searchResult, bool? isLoading}) {
    return SearchState(
      searchHistory: searchHistory ?? this.searchHistory,
      searchResult: searchResult ?? this.searchResult,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
