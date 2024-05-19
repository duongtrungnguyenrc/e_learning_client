import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/domain/business/blocs/learning_summary.bloc.dart';
import 'package:lexa/domain/business/events/learning_summary_bloc.event.dart';
import 'package:lexa/domain/business/states/learning_summary_bloc.state.dart';
import 'package:lexa/domain/utils/sound.utils.dart';
import 'package:lexa/presentation/views/circular_avatar.dart';
import 'package:lexa/presentation/views/double_text_column.dart';
import 'package:lexa/presentation/views/learning_ranking_segment.dart';
import 'package:lexa/presentation/views/primary_button.dart';
import 'package:lottie/lottie.dart';

class LearningSummaryScreen extends StatefulWidget {
  final String topicId;

  const LearningSummaryScreen({super.key, required this.topicId});

  @override
  State<LearningSummaryScreen> createState() => _LearningSummaryScreenState();
}

class _LearningSummaryScreenState extends State<LearningSummaryScreen> {
  late LearningSummaryBloc _learningSummaryBloc;

  @override
  void initState() {
    super.initState();
    _learningSummaryBloc = context.read<LearningSummaryBloc>();
    _learningSummaryBloc.add(LoadSummary(topicId: widget.topicId));

    SoundUtil().playSound("/sounds/congratulation_sound.mp3");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Summary",
          style: Theme.of(context).textTheme.displayMedium,
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          BlocBuilder<LearningSummaryBloc, LearningSummaryState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LearningRankingSegment(
                    top3: state.summary ?? [],
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorConstants.primaryBlue,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(15),
                        ),
                      ),
                      padding: const EdgeInsets.all(15),
                      child: ListView.separated(
                        itemCount: state.summary != null
                            ? (state.summary!.length > 4
                                ? state.summary!.length - 4
                                : state.summary!.length)
                            : 0,
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                        itemBuilder: (context, index) => Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: ColorConstants.lightGrey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 10,
                            children: [
                              ClipOval(
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: ColorConstants.primaryGray,
                                  ),
                                  child: Center(
                                    child: Text(
                                      index.toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              CircularAvatar(
                                imageUrl: state.summary![index].user.avatar,
                                size: 40,
                              ),
                              DoubleTextColumn(
                                mainText: state.summary![index].user.name,
                                mainTextSize: 16,
                                subText:
                                    "Correct: ${state.summary![index].correctAnswers}",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          IgnorePointer(
            child: LottieBuilder.asset(
              "assets/animations/congratulations.json",
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          child: PrimaryButton(
            onPressed: () {
              Navigator.pop(context);
            },
            text: "Finish",
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _learningSummaryBloc.add(ClearSummary());
  }
}
