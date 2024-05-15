import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lexa/domain/business/blocs/offline_data.bloc.dart';
import 'package:lexa/domain/business/states/offline_data_bloc.state.dart';
import 'package:lexa/presentation/features/main/widgets/saved_topic_item.dart';
import 'package:lexa/presentation/shared/widgets/segment_header.dart';

class LibraryTab extends StatelessWidget {
  const LibraryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OfflineDataBloc, OfflineDataState>(
        builder: (context, state) {
      final topics = state.savedTopics.values.toList();

      return SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: SegmentHeader(heading: "Saved topics:"),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ListView.builder(
                  itemCount: topics.length,
                  itemBuilder: (context, index) =>
                      SavedTopicItem(topic: topics[index]),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
