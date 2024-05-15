import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lexa/core/exceptions/network.exception.dart';
import 'package:lexa/domain/business/events/search_bloc.event.dart';
import 'package:lexa/domain/business/states/search_bloc.state.dart';
import 'package:lexa/domain/repositories/search.repository.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState()) {
    on<Search>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      try {
        final response = await SearchRepository.searchByKey(event.keyword, null);

        emit(
          state.copyWith(
            searchResult: [...response.data.profiles, ...response.data.topics],
            isLoading: false,
          ),
        );
      } on NetworkException catch (e) {
        print(e);
      }
    });

    on<ClearSearch>((event, emit) {
      emit(state.copyWith(searchResult: []));
    });
  }
}
