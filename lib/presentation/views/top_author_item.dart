import 'package:flutter/material.dart';
import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/data/models/user.model.dart';
import 'package:lexa/presentation/views/circular_avatar.dart';
import 'package:lexa/presentation/views/primary_button.dart';

class TopAuthorItem extends StatelessWidget {
  final int index;
  final User? user;
  final VoidCallback onTap;

  const TopAuthorItem({
    super.key,
    required this.index,
    required this.user,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const double avatarSize = 70;

    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: ColorConstants.primaryGrey,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(10),
        width: 140,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
                child: CircularAvatar(
              imageUrl: user?.avatar ?? "",
              size: avatarSize,
            )),
            SizedBox(
              height: user != null ? 2 : 5,
            ),
            user != null
                ? Text(
                    user!.name.split(' ')[0],
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  )
                : skeleton(50, 15, borderRadius: 10),
            SizedBox(
              height: user != null ? 0 : 5,
            ),
            user != null
                ? Text(
                    user?.email ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                : const SizedBox.shrink(),
            user != null
                ? PrimaryButton(
                    onPressed: () {},
                    text: "Follow",
                    textSize: 14,
                    borderRadius: 5,
                    padding: const EdgeInsets.all(3),
                  )
                : skeleton(80, 20, borderRadius: 5),
          ],
        ),
      ),
    );
  }
}
