import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/data/models/topic.model.dart';
import 'package:lexa/domain/business/blocs/learning.bloc.dart';
import 'package:lexa/domain/business/blocs/offline_data.bloc.dart';
import 'package:lexa/domain/business/blocs/topic.bloc.dart';
import 'package:lexa/domain/business/events/learning_bloc.event.dart';
import 'package:lexa/domain/business/events/offline_data_bloc.event.dart';
import 'package:lexa/domain/business/events/topic_bloc.event.dart';
import 'package:lexa/domain/business/states/topic.state.dart';
import 'package:lexa/presentation/views/author_segment.dart';
import 'package:lexa/presentation/views/learning_history_segment.dart';
import 'package:lexa/presentation/views/learning_option_picker_segment.dart';
import 'package:lexa/presentation/views/vocabulary_list_segment.dart';
import 'package:lexa/core/commons/button_size.dart';
import 'package:lexa/presentation/views/back_app_bar.dart';
import 'package:lexa/presentation/views/circular_icon_button.dart';
import 'package:lexa/presentation/views/primary_button.dart';
import 'package:lexa/presentation/views/segment_header.dart';

class TopicDetailPage extends StatefulWidget {
  final String id;
  final Topic? topic;

  const TopicDetailPage({
    Key? key,
    required this.id,
    this.topic,
  }) : super(key: key);

  @override
  State<TopicDetailPage> createState() => _TopicDetailPageState();
}

class _TopicDetailPageState extends State<TopicDetailPage> {
  final ScrollController _controller = ScrollController();
  late bool _isBottomPosition = false;
  late MediaQueryData _mediaQueryData;

  late TopicBloc _topicBloc;
  late OfflineDataBloc _offlineDataBloc;
  late LearningBloc _learningBloc;

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      setState(() {
        _isBottomPosition = _controller.offset >=
            _mediaQueryData.size.height / 4 - _mediaQueryData.padding.top;
      });
    });

    _topicBloc = context.read<TopicBloc>();
    _offlineDataBloc = context.read<OfflineDataBloc>();
    _topicBloc.add(Loadtopic(id: widget.id));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _mediaQueryData = MediaQuery.of(context);

    final Topic? topic = _topicBloc.state.getNode(widget.id) ?? widget.topic;
    _learningBloc = context.read<LearningBloc>();
    _learningBloc.add(LoadLearningHistory(topicId: topic?.id));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopicBloc, TopicState>(
      builder: (context, state) {
        final Topic? topic =
            _topicBloc.state.getNode(widget.id) ?? widget.topic;

        return Scaffold(
          appBar: BackAppBar(
            background: Colors.transparent,
            title: "Topic ${topic?.name}",
          ),
          extendBodyBehindAppBar: true,
          backgroundColor: ColorConstants.white,
          body: Stack(
            children: [
              AnimatedContainer(
                duration: const Duration(seconds: 300),
                decoration: BoxDecoration(
                  color: _isBottomPosition
                      ? ColorConstants.white
                      : Colors.transparent,
                ),
                child: _buildBackgroundImage(topic),
              ),
              SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        controller: _controller,
                        child: Container(
                          margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 6,
                          ),
                          decoration: BoxDecoration(
                            color: ColorConstants.white,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildHeader(topic),
                                const SizedBox(height: 5),
                                _buildDescription(topic),
                                const SizedBox(height: 30),
                                AuthorSegment(author: topic?.author),
                                const SizedBox(height: 20),
                                LearningHistorySegment(
                                  topicId: topic?.id,
                                ),
                                const SizedBox(height: 20),
                                topic != null
                                    ? LearningOptionPickerSegment(topic: topic)
                                    : const SizedBox.shrink(),
                                const SizedBox(height: 20),
                                topic != null
                                    ? VocabularyListSegment(topic: topic)
                                    : const SizedBox.shrink(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    _buildFooter(context, topic),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBackgroundImage(Topic? topic) {
    if (_isBottomPosition) {
      return const SizedBox.shrink();
    } else {
      return CachedNetworkImage(
        fit: BoxFit.cover,
        width: _mediaQueryData.size.width,
        height: _mediaQueryData.size.height / 2,
        placeholder: (_, __) => _buildSkeleton(
            _mediaQueryData.size.width, _mediaQueryData.size.height / 2),
        imageUrl: topic?.thumbnail ?? "",
        errorWidget: (_, __, ___) => _buildSkeleton(
            _mediaQueryData.size.width, _mediaQueryData.size.height / 2),
      );
    }
  }

  Widget _buildHeader(Topic? topic) {
    return Row(
      children: [
        Expanded(
          child: topic != null
              ? SegmentHeader(
                  heading: "Topic: ${topic.name}",
                  headingStyle: Theme.of(context).textTheme.displayLarge,
                )
              : _buildSkeleton(50, 20, borderRadius: 10),
        ),
        const SizedBox(width: 10),
        topic != null
            ? CircularIconButton(
                iconPath: topic.isDownloaded != null && topic.isDownloaded!
                    ? "assets/icons/download_icon.svg"
                    : "assets/icons/checkmark_icon.svg",
                enable: topic.isDownloaded ?? true,
                size: 40,
                iconColor: ColorConstants.primaryGray,
                elevation: 0,
                borderSide: BorderSide(
                  width: 0.5,
                  color: ColorConstants.primaryGrey,
                ),
                onTap: () {
                  _offlineDataBloc.add(SaveTopic(topic));
                },
              )
            : _buildSkeleton(40, 40, borderRadius: 40),
      ],
    );
  }

  Widget _buildDescription(Topic? topic) {
    return topic != null
        ? Text(
            "Description: ${topic.description}",
            overflow: TextOverflow.ellipsis,
            maxLines: 5,
            style: const TextStyle(fontSize: 12),
          )
        : _buildSkeleton(100, 10, borderRadius: 5);
  }

  Widget _buildFooter(BuildContext context, Topic? topic) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstants.white,
        border: Border(
          top: BorderSide(width: 2.0, color: ColorConstants.primaryGrey),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: topic != null
            ? PrimaryButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => SingleChildScrollView(
                      child: Container(
                        color: ColorConstants.white,
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 40),
                        child: LearningOptionPickerSegment(topic: topic),
                      ),
                    ),
                  );
                },
                padding: const EdgeInsets.symmetric(vertical: 13),
                textSize: 18,
                text: "Start learning",
                size: ButtonSize.expanded,
              )
            : _buildSkeleton(double.infinity, 50, borderRadius: 10),
      ),
    );
  }

  Widget _buildSkeleton(double width, double height,
      {double borderRadius = 0}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: ColorConstants.primaryGrey,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}
