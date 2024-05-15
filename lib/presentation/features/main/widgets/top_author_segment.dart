import 'package:flutter/material.dart';
import 'package:lexa/data/models/user.model.dart';
import 'package:lexa/presentation/features/main/pages/profile_page.dart';
import 'package:lexa/presentation/features/main/widgets/horizontal_list_items_segment.dart';
import 'package:lexa/presentation/features/main/widgets/top_author_item.dart';

class TopAuthorSegment extends StatelessWidget {
  final List<User> users;
  const TopAuthorSegment({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: users.isNotEmpty
          ? HorizontalListItemsSegment<User>(
              speratedBuilder: (context, index) => const SizedBox(
                width: 10,
              ),
              height: 180,
              itemBuilder: (user, index) => TopAuthorItem(
                index: index ?? 0,
                user: user,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(id: user.id),
                    ),
                  );
                },
              ),
              title: "Top author",
              subAction: () {},
              items: users,
            )
          : HorizontalListItemsSegment<dynamic>(
              speratedBuilder: (context, index) => const SizedBox(
                width: 5,
              ),
              itemBuilder: (user, index) => TopAuthorItem(
                index: index ?? 0,
                user: user,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(id: user.id),
                    ),
                  );
                },
              ),
              title: "Top author",
              subAction: () {},
              items: List.generate(10, (index) => null),
            ),
    );
  }
}
