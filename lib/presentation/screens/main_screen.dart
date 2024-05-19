import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/domain/business/blocs/home.bloc.dart';
import 'package:lexa/domain/business/events/home_bloc.event.dart';
import 'package:lexa/presentation/tabs/library_tab.dart';
import 'package:lexa/presentation/views/home_header.dart';
import 'package:lexa/presentation/screens/manage_topic_screen.dart';
import 'package:lexa/presentation/tabs/home_tab.dart';
import 'package:lexa/presentation/tabs/profile_tab.dart';
import 'package:lexa/presentation/tabs/setting_tab.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  late Homebloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = context.read<Homebloc>();
  }

  static const List<Widget> _screens = <Widget>[
    HomeTab(),
    LibraryTab(),
    SizedBox.shrink(),
    ProfileTab(),
    SettingTab(),
  ];

  void _onItemTapped(int index) {
    if (index == 2) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ManageTopicScreen()));
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
        children: _screens,
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

  @override
  void dispose() {
    _homeBloc.add(ClearHomeData());
    super.dispose();
  }
}
