import 'package:flutter/material.dart';
import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/presentation/features/main/tabs/library_tab.dart';
import 'package:lexa/presentation/features/main/widgets/home_header.dart';
import 'package:lexa/presentation/features/topic/pages/manage_topic_page.dart';
import 'package:lexa/presentation/features/main/tabs/home_tab.dart';
import 'package:lexa/presentation/features/main/tabs/profile_tab.dart';
import 'package:lexa/presentation/features/main/tabs/setting_tab.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    HomeTab(),
    LibraryTab(),
    SizedBox.shrink(),
    ProfileTab(),
    SettingTab(),
  ];

  void _onItemTapped(int index) {
    if (index == 2) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ManageTopicPage()));
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.white,
      appBar: const HomeHeader(),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) => _onItemTapped(value),
        currentIndex: _selectedIndex,
        unselectedLabelStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
        selectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
        unselectedItemColor: ColorConstants.primaryGray,
        selectedItemColor: ColorConstants.primary,
        showUnselectedLabels: true,
        backgroundColor: ColorConstants.white,
        type: BottomNavigationBarType.fixed,
        items: MainPageConstants.navigationItems,
      ),
    );
  }
}
