import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/data/models/profile.model.dart';
import 'package:lexa/presentation/views/circular_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:lexa/presentation/views/circular_avatar.dart';
import 'package:lexa/presentation/views/double_text_column.dart';
import 'package:lexa/presentation/views/svg_icon.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Profile? profile;
  final bool Function()? onBack;
  final Function(DragTargetDetails<Object?>)? onDrop;

  const ChatAppBar({
    Key? key,
    required this.profile,
    this.onBack,
    this.onDrop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey[200]!,
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularIconButton(
              background: Colors.transparent,
              iconPath: "assets/icons/left_arrow_icon.svg",
              size: 40,
              elevation: 0,
              iconSize: 20,
              onTap: () {
                if (onBack == null) {
                  Navigator.pop(context);
                } else {
                  final canBack = onBack!();
                  if (canBack) Navigator.pop(context);
                }
              },
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularAvatar(
                    imageUrl: profile?.avatar ?? "",
                    size: 40,
                    borderColor: ColorConstants.primaryGrey,
                    errorWidget: Image.network(dotenv.env['RANDOM_AVATAR_URL'] ?? ""),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: DoubleTextColumn(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainTextSize: 16,
                      subTextSize: 12,
                      mainText: profile?.name ?? "",
                      subText: profile?.email ?? "",
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 15,
              ),
              child: PopupMenuButton(
                padding: const EdgeInsets.all(10),
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    child: Text("Remove"),
                  ),
                ],
                child: const SvgIcon(
                  assetUrl: "assets/icons/elipsis_icon.svg",
                  color: Colors.black,
                  size: 22,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);
}
