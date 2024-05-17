import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/data/dtos/create_topic.dto.dart';
import 'package:lexa/presentation/views/circular_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:lexa/presentation/views/svg_icon.dart';

class AddingVocabularyControlSegment extends StatefulWidget {
  final List<CreateVocabularyDto> vocabularies;
  final Function(int) onItemTap;
  final Function(int) onItemRemove;
  final Function onAddItem;
  final int activeIndex;

  const AddingVocabularyControlSegment({
    super.key,
    required this.vocabularies,
    required this.onItemTap,
    required this.onItemRemove,
    required this.onAddItem,
    required this.activeIndex,
  });

  @override
  State<AddingVocabularyControlSegment> createState() => _AddingVocabularyControlSegmentState();
}

class _AddingVocabularyControlSegmentState extends State<AddingVocabularyControlSegment> {
  final ScrollController _scrollController = ScrollController();
  final _itemWidth = 120.0;
  final _separatorWidth = 10;

  @override
  Widget build(BuildContext context) {
    double activeItemOffset = 0.0;
    if (widget.activeIndex <= 1) {
      activeItemOffset = 0;
    } else if (widget.activeIndex == widget.vocabularies.length - 1 && widget.vocabularies.length != 1) {
      activeItemOffset = (_itemWidth + _separatorWidth) * (widget.vocabularies.length - 2) - 22;
    } else {
      activeItemOffset = (_itemWidth + _separatorWidth) * widget.activeIndex - _itemWidth / 2;
    }

    _scrollController.animateTo(
      activeItemOffset,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SizedBox(
              height: 70,
              child: ListView.separated(
                controller: _scrollController,
                itemCount: widget.vocabularies.length,
                itemBuilder: (context, index) {
                  return _buildVocabularyItem(index, widget.vocabularies[index]);
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 10,
                  );
                },
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          CircularIconButton(
            iconPath: "assets/icons/plus_icon.svg",
            iconColor: Colors.white,
            size: 60,
            background: ColorConstants.primary,
            onTap: widget.onAddItem,
          ),
        ],
      ),
    );
  }

  Widget _buildVocabularyItem(int index, CreateVocabularyDto vocabulary) {
    return InkWell(
      onTap: () => widget.onItemTap(index),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: index == widget.activeIndex ? Colors.black : Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        width: _itemWidth,
        height: 70,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(11),
              child: SizedBox(
                width: 120,
                height: 70,
                child: vocabulary.thumbnail != null
                    ? Image.file(
                        vocabulary.thumbnail!,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        color: Colors.grey,
                      ),
              ),
            ),
            Positioned(
              top: 17.5,
              left: 10,
              right: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 35,
                    height: 35,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        (index + 1).toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      onPressed: () => widget.onItemRemove(index),
                      padding: const EdgeInsets.all(0),
                      icon: const SvgIcon(
                        assetUrl: "assets/icons/trash_icon.svg",
                        size: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
}
