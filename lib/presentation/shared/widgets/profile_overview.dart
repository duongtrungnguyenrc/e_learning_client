import 'package:flutter/widgets.dart';
import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/presentation/shared/widgets/circular_avatar.dart';
import 'package:lexa/presentation/shared/widgets/double_text_column.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileOverview extends StatelessWidget {
  final bool isLoading;
  final String? avatarUrl;
  final String? name;
  final String? story;
  final int? followers;
  final int? topics;
  final int? archivements;

  const ProfileOverview({
    super.key,
    this.isLoading = false,
    this.avatarUrl,
    this.name,
    this.story,
    this.followers,
    this.topics,
    this.archivements,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: screenSize.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircularAvatar(
            imageUrl: avatarUrl ?? "",
            size: screenSize.width / 3,
          ),
          const SizedBox(
            height: 10,
          ),
          isLoading
              ? skeleton(screenSize.width, 15)
              : DoubleTextColumn(
                  mainText: name ?? "User",
                  mainTextFont: "Quicksand",
                  mainTextSize: 20,
                  subText: story ?? "...",
                  subTextFont: "Mulish",
                  subTextSize: 12,
                  subTextWeight: FontWeight.w500,
                ),
        ],
      ),
    );
  }
}
