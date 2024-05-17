import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/data/models/learning_session.model.dart';
import 'package:lexa/domain/business/blocs/learning.bloc.dart';
import 'package:lexa/domain/business/events/learning_bloc.event.dart';
import 'package:lexa/domain/business/states/learning_bloc.state.dart';
import 'package:lexa/presentation/views/segment_header.dart';
import 'package:flutter/material.dart';
import 'package:lexa/domain/utils/date.utils.dart';

class LearningHistorySegment extends StatefulWidget {
  final String? topicId;
  const LearningHistorySegment({super.key, required this.topicId});

  @override
  State<LearningHistorySegment> createState() => _LearningHistorySegmentState();
}

class _LearningHistorySegmentState extends State<LearningHistorySegment>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late LearningBloc _learningBloc;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
    _learningBloc = context.read<LearningBloc>();

    _learningBloc.add(LoadLearningHistory(topicId: widget.topicId));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LearningBloc, LearningState>(builder: (context, state) {
      List<List<LearningSession>> learningSessions = [[], [], []];

      for (var node in state.nodes) {
        DateTime nodeDate = DateFormat('HH:mm dd/MM/yyyy').parse(node.time);
        String period = checkDate(nodeDate);

        if (period == 'Today') {
          learningSessions[0].add(node);
        } else if (period == 'Last Week') {
          learningSessions[1].add(node);
        } else if (period == 'Last Month') {
          learningSessions[2].add(node);
        }
      }
      return Column(
        children: [
          const SegmentHeader(
            heading: "Your learning history",
          ),
          const SizedBox(
            height: 10,
          ),
          Material(
            elevation: 1,
            borderRadius: const BorderRadius.all(
              Radius.circular(13),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: ColorConstants.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(13),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    TabBar(
                      controller: _tabController,
                      unselectedLabelStyle: TextStyle(
                        color: ColorConstants.black,
                        fontWeight: FontWeight.w600,
                      ),
                      labelStyle: TextStyle(
                        color: ColorConstants.primary,
                        fontWeight: FontWeight.w600,
                      ),
                      indicatorColor: ColorConstants.primary,
                      isScrollable: true,
                      tabAlignment: TabAlignment.center,
                      tabs: const [
                        Tab(
                          text: "Last day",
                        ),
                        Tab(
                          text: "Last week",
                        ),
                        Tab(
                          text: "Last month",
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    learningSessions.isNotEmpty
                        ? ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                learningSessions[_tabController.index].length,
                            itemBuilder: (context, index) {
                              var learningSession =
                                  learningSessions[_tabController.index][index];

                              return Container(
                                padding: const EdgeInsets.all(15),
                                child: Text(learningSession.time),
                              );
                            },
                          )
                        : Text(
                            "No records",
                            style: TextStyle(
                              fontSize: 12,
                              color: ColorConstants.primaryGrey,
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
