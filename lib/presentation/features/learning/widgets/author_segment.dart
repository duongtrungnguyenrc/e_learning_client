import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/data/models/user.model.dart';
import 'package:lexa/presentation/shared/widgets/circular_icon_button.dart';
import 'package:lexa/presentation/shared/widgets/circular_avatar.dart';
import 'package:lexa/presentation/shared/widgets/double_text_column.dart';
import 'package:lexa/presentation/shared/widgets/segment_header.dart';
import 'package:flutter/material.dart';

class AuthorSegment extends StatelessWidget {
  final User? author;
  const AuthorSegment({super.key, required this.author});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SegmentHeader(
          heading: "Author",
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            CircularAvatar(
              imageUrl: author?.avatar ?? "",
              size: 50,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  author != null
                      ? DoubleTextColumn(
                          mainText: author!.name,
                          mainTextFont: "Quicksand",
                          mainTextSize: 16,
                          mainTextWeight: FontWeight.w700,
                          subText: author!.email,
                          subTextFont: "Mulish",
                          subTextSize: 12,
                          subTextWeight: FontWeight.w500,
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            skeleton(80, 10, borderRadius: 5),
                            const SizedBox(
                              height: 5,
                            ),
                            skeleton(120, 10, borderRadius: 5)
                          ],
                        ),
                  author != null
                      ? CircularIconButton(
                          iconPath: "assets/icons/message_icon.svg",
                          size: 40,
                          borderSide: BorderSide(
                            width: 0.5,
                            color: ColorConstants.primaryGrey,
                          ),
                          onTap: () {
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => ChatPage(
                            //         profile: author,
                            //       ),
                            //     ),
                            //   );
                          },
                          iconSize: 20,
                          elevation: 0,
                        )
                      : skeleton(40, 40, borderRadius: 40),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
