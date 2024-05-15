import 'package:lexa/presentation/features/chat/pages/chat_home_page.dart';
import 'package:lexa/presentation/features/search/pages/search_page.dart';
import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/presentation/shared/widgets/circular_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:lexa/presentation/shared/widgets/svg_icon.dart';

class HomeHeader extends StatefulWidget implements PreferredSizeWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();

  @override
  Size get preferredSize => const Size(double.infinity, 100);
}

class _HomeHeaderState extends State<HomeHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: ColorConstants.white,
          border: const Border(
              bottom: BorderSide(
            color: Color.fromARGB(255, 242, 242, 242),
            width: 1,
          ))),
      padding: EdgeInsets.only(
        left: 15,
        right: 5,
        bottom: 5,
        top: MediaQuery.of(context).padding.top + 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgIcon(
            assetUrl: "assets/icons/top_logo_icon.svg",
            size: 50,
            color: ColorConstants.primary,
          ),
          Wrap(
            children: [
              CircularIconButton(
                iconPath: "assets/icons/chat_icon.svg",
                iconSize: 18,
                elevation: 0,
                borderSide: BorderSide(
                  width: 1,
                  color: ColorConstants.primaryGrey,
                ),
                size: 35,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChatHomePage(),
                    ),
                  );
                },
              ),
              CircularIconButton(
                iconPath: "assets/icons/search_icon.svg",
                iconSize: 15,
                elevation: 0,
                borderSide: BorderSide(
                  width: 1,
                  color: ColorConstants.primaryGrey,
                ),
                size: 35,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SearchPage()));
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
