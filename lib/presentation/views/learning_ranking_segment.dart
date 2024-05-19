import 'package:flutter/material.dart';
import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/data/models/learning_session_summary.model.dart';
import 'package:lexa/presentation/views/circular_avatar.dart';

class LearningRankingSegment extends StatefulWidget {
  final List<LearningSessionSummary> top3;

  const LearningRankingSegment({super.key, required this.top3});

  @override
  State<LearningRankingSegment> createState() => _LearningRankingSegmentState();
}

class _LearningRankingSegmentState extends State<LearningRankingSegment> {
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _isExpanded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 330,
        minHeight: 300,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                widget.top3.length > 3 ? 3 : widget.top3.length,
                (index) => _buildRankLevel(context, index)),
          ),
        ],
      ),
    );
  }

  Widget _buildRankLevel(BuildContext context, int index) {
    double expandedWidth = (MediaQuery.of(context).size.width - 40) / 3;
    double expandedHeight = 70 + (index * 60);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Wrap(
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            CircularAvatar(
              imageUrl: widget.top3[index].user.avatar,
              size: 60,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
              ),
              width: expandedWidth,
              child: Text(
                widget.top3[index].user.name,
                overflow: TextOverflow.clip,
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        AnimatedContainer(
          duration: const Duration(seconds: 1),
          width: expandedWidth,
          height: _isExpanded ? expandedHeight : 0,
          decoration: BoxDecoration(
            color: ColorConstants.green,
            border: Border(
              right: BorderSide(
                width: 3,
                color: ColorConstants.primaryGrey,
              ),
              top: BorderSide(
                width: 3,
                color: ColorConstants.primaryGrey,
              ),
            ),
          ),
          child: Center(
            child: Text(
              ((index - 3) * -1).toString(),
              style: const TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}
