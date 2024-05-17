import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/domain/business/blocs/search.bloc.dart';
import 'package:lexa/domain/business/events/search_bloc.event.dart';
import 'package:lexa/domain/business/states/search_bloc.state.dart';
import 'package:lexa/presentation/views/search_result_list.dart';
import 'package:lexa/presentation/views/search_text_field.dart';
import 'package:lexa/presentation/views/back_app_bar.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late SearchBloc _searchBloc;

  @override
  void initState() {
    super.initState();
    _searchBloc = context.read<SearchBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorConstants.white,
          appBar: const BackAppBar(
            title: "Search",
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Column(
                children: [
                  SearchTextField(
                    onChanged: _handleSearch,
                    border: Border.all(color: ColorConstants.lightPrimary),
                  ),
                  SearchResultList(
                    loading: state.isLoading,
                    results: state.searchResult ?? [],
                    isDisplay: true,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _clearSearchResult();
  }

  void _handleSearch(String keyword) {
    if (keyword.isNotEmpty) {
      _searchBloc.add(Search(keyword: keyword));
    } else {
      _clearSearchResult();
    }
  }

  void _clearSearchResult() {
    _searchBloc.add(ClearSearch());
  }
}
