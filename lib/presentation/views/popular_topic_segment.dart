import 'package:flutter/material.dart';
import 'package:lexa/data/models/topic.model.dart';
import 'package:lexa/presentation/screens/topic_detail_screen.dart';
import 'package:lexa/presentation/views/horizontal_list_items_segment.dart';
import 'package:lexa/presentation/views/popular_topic_item.dart';

class PopularTopicSegment extends StatefulWidget {
  final List<Topic> topics;
  const PopularTopicSegment({super.key, required this.topics});

  @override
  State<PopularTopicSegment> createState() => _PopularTopicSegmentState();
}

class _PopularTopicSegmentState extends State<PopularTopicSegment>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: widget.topics.isNotEmpty
          ? HorizontalListItemsSegment<Topic>(
              speratedBuilder: (context, index) => const SizedBox(
                width: 10,
              ),
              height: 120,
              itemBuilder: (topic, index) => PopularTopicItem(
                topic: topic,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TopicDetailPage(
                        id: topic.id,
                      ),
                    ),
                  );
                },
              ),
              title: "Topic you may like",
              subAction: () {},
              items: widget.topics,
            )
          : HorizontalListItemsSegment<dynamic>(
              speratedBuilder: (context, index) => const SizedBox(
                width: 5,
              ),
              itemBuilder: (topic, index) => PopularTopicItem(
                topic: topic,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TopicDetailPage(
                        id: topic.id,
                      ),
                    ),
                  );
                },
              ),
              title: "Topic you may like",
              items: List.generate(10, (index) => null),
            ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
