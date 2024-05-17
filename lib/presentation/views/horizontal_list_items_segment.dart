import 'package:lexa/presentation/views/segment_header.dart';
import 'package:flutter/material.dart';

class HorizontalListItemsSegment<T> extends StatefulWidget {
  final String title;
  final List<T> items;
  final Function(T, int?) itemBuilder;
  final List? filterItems;
  final Function? filterCondition;
  final Function? subAction;
  final Widget Function(BuildContext context, int index)? speratedBuilder;
  final double? height;

  const HorizontalListItemsSegment({
    Key? key,
    required this.title,
    required this.items,
    required this.itemBuilder,
    this.filterItems,
    this.filterCondition,
    this.subAction,
    this.speratedBuilder,
    this.height,
  }) : super(key: key);

  @override
  State<HorizontalListItemsSegment<T>> createState() => _HorizontalListItemsSegmentState<T>();
}

class _HorizontalListItemsSegmentState<T> extends State<HorizontalListItemsSegment<T>>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SegmentHeader(
          heading: widget.title,
          action: widget.subAction,
        ),
        const SizedBox(
          height: 10,
        ),
        // SizedBox(
        //   width: MediaQuery.of(context).size.width,
        //   height: 150,
        //   child: ListView.builder(
        //     scrollDirection: Axis.horizontal,
        //     itemCount: filterItems?.length ?? 0,
        //     itemBuilder: (context, index) {
        //       T item = items[index];
        //       return HorizontalListFilterItem(itemName: itemName, isSelected: isSelected, onSelected: onSelected);
        //     },
        //   ),
        // ),
        // const SizedBox(
        //   height: 10,
        // ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: widget.height ?? 150,
          child: ListView.separated(
            shrinkWrap: true,
            separatorBuilder: widget.speratedBuilder ?? (context, index) => const SizedBox.shrink(),
            scrollDirection: Axis.horizontal,
            itemCount: widget.items.length,
            itemBuilder: (context, index) {
              T item = widget.items[index];
              return widget.itemBuilder(item, index);
            },
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
