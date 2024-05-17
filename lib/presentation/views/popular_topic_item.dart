import 'package:cached_network_image/cached_network_image.dart';
import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/data/models/topic.model.dart';
import 'package:flutter/material.dart';

class PopularTopicItem extends StatefulWidget {
  final Topic? topic;
  final VoidCallback onTap;

  const PopularTopicItem({
    super.key,
    required this.topic,
    required this.onTap,
  });

  @override
  State<PopularTopicItem> createState() => _PopularTopicItemState();
}

class _PopularTopicItemState extends State<PopularTopicItem> {
  @override
  Widget build(BuildContext context) {
    const double itemWith = 140;
    const double itemHeight = 80;

    return GestureDetector(
      onTap: widget.onTap,
      child: SizedBox(
        width: 140,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: widget.topic != null
                  ? CachedNetworkImage(
                      imageUrl: widget.topic!.thumbnail,
                      height: itemHeight,
                      width: itemWith,
                      placeholder: (context, url) => skeleton(
                        itemWith,
                        itemHeight,
                        borderRadius: 10,
                      ),
                      fit: BoxFit.cover,
                    )
                  : skeleton(itemWith, itemHeight),
            ),
            SizedBox(
              height: widget.topic != null ? 5 : 10,
            ),
            widget.topic != null
                ? Text(
                    widget.topic!.name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  )
                : skeleton(itemWith, 15, borderRadius: 10),
          ],
        ),
      ),
    );
  }
}
