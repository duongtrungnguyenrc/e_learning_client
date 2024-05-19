import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/data/models/learning_session.model.dart';
import 'package:lexa/domain/business/blocs/learning.bloc.dart';
import 'package:lexa/domain/business/states/learning_bloc.state.dart';
import 'package:lexa/presentation/views/segment_header.dart';
import 'package:flutter/material.dart';

import '../../data/models/learning_record.model.dart';

class LearningHistorySegment extends StatefulWidget {
  final String? topicId;
  const LearningHistorySegment({super.key, required this.topicId});

  @override
  State<LearningHistorySegment> createState() => _LearningHistorySegmentState();
}

class _LearningHistorySegmentState extends State<LearningHistorySegment>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LearningBloc, LearningState>(builder: (context, state) {
      final topicSessions = state.getNode(widget.topicId);
      return Column(
        children: [
          const SegmentHeader(
            heading: "Your learning history",
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              color: ColorConstants.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(13),
              ),
              border: Border.all(
                color: ColorConstants.primaryGrey,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 15,
              ),
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
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: _isExpanded ? double.infinity : 200,
                    ),
                    child: topicSessions != null && topicSessions.isNotEmpty
                        ? Scrollbar(
                            child: ListView.separated(
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 10,
                              ),
                              physics: _isExpanded
                                  ? const NeverScrollableScrollPhysics()
                                  : const ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: topicSessions.length,
                              itemBuilder: (context, index) {
                                var learningSession = topicSessions[index];

                                return _buildLearningHistoryItem(
                                    learningSession);
                              },
                            ),
                          )
                        : Text(
                            "No records",
                            style: TextStyle(
                              fontSize: 12,
                              color: ColorConstants.primaryGrey,
                            ),
                          ),
                  ),
                  Center(
                    child: topicSessions != null && topicSessions.isNotEmpty
                        ? TextButton(
                            child: Text(
                              _isExpanded ? "Minimize" : "View more",
                              style: TextStyle(
                                color: ColorConstants.primary,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                _isExpanded = !_isExpanded;
                              });
                            },
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildLearningHistoryItem(LearningSession learningSession) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorConstants.primaryGrey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Wrap(
        direction: Axis.vertical,
        spacing: 10,
        children: [
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: "Time to learn:  ",
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorConstants.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: learningSession.time,
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorConstants.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: "Method:  ",
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorConstants.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text:
                      LearningMethodExtension.fromString(learningSession.method)
                          ?.getString(),
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorConstants.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorConstants.green,
                    fontWeight: FontWeight.w600,
                  ),
                  children: <TextSpan>[
                    const TextSpan(text: "Correct: "),
                    TextSpan(
                      text: learningSession.records
                          .where((record) =>
                              record is LearningRecord ? record.isTrue : false)
                          .length
                          .toString(),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorConstants.red,
                    fontWeight: FontWeight.w600,
                  ),
                  children: <TextSpan>[
                    const TextSpan(
                      text: "Incorrect: ",
                    ),
                    TextSpan(
                      text: learningSession.records
                          .where((record) =>
                              record is LearningRecord ? !record.isTrue : false)
                          .length
                          .toString(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
