import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/domain/business/blocs/home.bloc.dart';
import 'package:lexa/domain/business/events/home_bloc.event.dart';
import 'package:lexa/domain/business/states/home_bloc.state.dart';
import 'package:lexa/presentation/views/popular_topic_segment.dart';
import 'package:lexa/presentation/views/post_recommend_segment.dart';
import 'package:flutter/material.dart';
import 'package:lexa/presentation/views/top_author_segment.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late Homebloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = context.read<Homebloc>();
    _homeBloc.add(LoadRecommendTopics());
    _homeBloc.add(LoadTopAuthor());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Homebloc, HomeBlocState>(builder: (context, state) {
      return PopScope(
        canPop: false,
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: ColorConstants.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).padding.top,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: PopularTopicSegment(
                    topics: state.recommendTopics,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TopAuthorSegment(users: state.topAuthors),
                ),
                const PostRecommendSegment(),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
