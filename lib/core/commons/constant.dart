// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:lexa/presentation/screens/setting_language_screen.dart';
import 'package:lexa/presentation/screens/setting_profile_screen.dart';

import 'package:lexa/presentation/views/loading_skeleton.dart';
import 'package:lexa/presentation/views/svg_icon.dart';

List<Color?> multipleChoiceAnswerColors = [
  Colors.blue[500],
  Colors.orange[500],
  Colors.purple[500],
  Colors.yellow[600],
];

class ColorConstants {
  static Color black = const Color(0xff000000);
  static Color white = const Color(0xffFFFFFF);
  static Color primary = const Color(0xff4285F4);
  static Color lightPrimary = const Color.fromARGB(255, 90, 150, 246);
  static Color primaryBlue = const Color(0xff0961F5);
  static Color lightBlue = const Color.fromARGB(255, 174, 202, 250);
  static Color lightGrey = const Color.fromARGB(255, 245, 245, 245);
  static Color primaryGray = const Color(0xff545454);
  static Color primaryGrey = const Color.fromARGB(255, 228, 230, 230);
  static Color green = const Color(0xff167F71);
  static Color red = const Color.fromARGB(255, 203, 29, 29);
}

Widget skeleton(double width, double height, {double? borderRadius}) {
  return LoadingSkeleton(
    borderRadius: borderRadius,
    width: width,
    height: height,
    colors: [
      Colors.grey[100]!,
      Colors.grey[400]!,
      Colors.grey[100]!,
    ],
  );
}

enum DragDirection {
  left,
  right,
  center,
}

class MainPageConstants {
  static List<BottomNavigationBarItem> navigationItems = [
    BottomNavigationBarItem(
      label: "Home",
      icon: const Padding(
        padding: EdgeInsets.only(bottom: 3),
        child: SvgIcon(
          assetUrl: "assets/icons/home_icon.svg",
        ),
      ),
      activeIcon: Padding(
        padding: const EdgeInsets.only(bottom: 3),
        child: SvgIcon(
          assetUrl: "assets/icons/home_icon.svg",
          color: ColorConstants.primary,
        ),
      ),
    ),
    BottomNavigationBarItem(
      label: "Library",
      icon: const Padding(
        padding: EdgeInsets.only(bottom: 3),
        child: SvgIcon(
          assetUrl: "assets/icons/discovery_icon.svg",
        ),
      ),
      activeIcon: Padding(
        padding: const EdgeInsets.only(bottom: 3),
        child: SvgIcon(
          assetUrl: "assets/icons/discovery_icon.svg",
          color: ColorConstants.primary,
        ),
      ),
    ),
    BottomNavigationBarItem(
      icon: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          decoration: BoxDecoration(color: ColorConstants.primary, shape: BoxShape.circle),
          padding: const EdgeInsets.all(18),
          child: SvgIcon(
            assetUrl: "assets/icons/plus_icon.svg",
            size: 20,
            color: ColorConstants.white,
          ),
        ),
      ),
      label: "",
    ),
    BottomNavigationBarItem(
      label: "Profile",
      icon: const Padding(
        padding: EdgeInsets.only(bottom: 3),
        child: SvgIcon(
          assetUrl: "assets/icons/profile_icon.svg",
        ),
      ),
      activeIcon: Padding(
        padding: const EdgeInsets.only(bottom: 3),
        child: SvgIcon(
          assetUrl: "assets/icons/profile_icon.svg",
          color: ColorConstants.primary,
        ),
      ),
    ),
    BottomNavigationBarItem(
      label: "Setting",
      icon: const Padding(
        padding: EdgeInsets.only(bottom: 3),
        child: SvgIcon(
          assetUrl: "assets/icons/setting_icon.svg",
        ),
      ),
      activeIcon: Padding(
        padding: const EdgeInsets.only(bottom: 3),
        child: SvgIcon(
          assetUrl: "assets/icons/setting_icon.svg",
          color: ColorConstants.primary,
        ),
      ),
    ),
  ];
}

enum QuestionLayout {
  list,
  grid;

  @override
  String toString() {
    switch (this) {
      case QuestionLayout.list:
        return 'List';
      case QuestionLayout.grid:
        return 'Grid';
      default:
        return '';
    }
  }
}

class SettingItem {
  String iconUrl;
  Color iconBackground;
  String title;
  String? subtitle;
  Widget? navigation;

  SettingItem({
    required this.iconUrl,
    required this.iconBackground,
    required this.title,
    this.subtitle,
    this.navigation,
  });
}

class SettingGroup {
  String? title;
  List<SettingItem> items;

  SettingGroup({
    this.title,
    required this.items,
  });
}

class SettingItemConstant {
  static List<SettingGroup> items = [
    SettingGroup(title: "Preferences", items: [
      SettingItem(
        iconUrl: "assets/icons/profile_icon.svg",
        iconBackground: Colors.blue,
        title: "Profile",
        subtitle: "Manage your profile",
        navigation: const SettingProfilePage(),
      ),
      SettingItem(
        iconUrl: "assets/icons/finger_print_icon.svg",
        iconBackground: Colors.red,
        title: "Privacy & Security",
        subtitle: "Check your privacy and account security",
      ),
      SettingItem(
        iconUrl: "assets/icons/language_icon.svg",
        iconBackground: Colors.green,
        title: "language",
        subtitle: "Manage your app language",
        navigation: const SettingLanguagePage(),
      ),
    ]),
    SettingGroup(items: [
      SettingItem(
        iconUrl: "assets/icons/power_off_icon.svg",
        iconBackground: Colors.red,
        title: "log out",
      ),
    ])
  ];
}

// snack bar

class NotificationSnackBar {
  static SnackBar success(String message) {
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: ColorConstants.green,
      content: Text(message),
    );
  }

  static SnackBar error(String message) {
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: ColorConstants.red,
      content: Text(message),
    );
  }
}

const languages = [
  {
    "name": "Vietnamese",
    "nativeName": "Tiếng Việt",
  },
  {
    "name": "English",
    "nativeName": "Tiếng Anh",
  }
];

const messagesLimit = 20;
