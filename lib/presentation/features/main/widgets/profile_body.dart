import 'package:flutter/material.dart';
import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/presentation/features/main/tabs/profile_information_tab.dart';
import 'package:lexa/presentation/features/main/tabs/profile_topics_tab.dart';
import 'package:lexa/presentation/features/main/widgets/custom_tab_bar_view.dart';

class ProfileBody extends StatefulWidget {
  final String? id;
  const ProfileBody({super.key, this.id});

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody>
    with TickerProviderStateMixin {
  int _activeIndex = 0;
  late TabController _tabController;
  late List<Widget> _tabs;

  @override
  initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabs = <Widget>[
      Container(),
      ProfileTopicsTab(id: widget.id),
      const ProfileInformationTab(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          child: TabBar(
            controller: _tabController,
            onTap: (index) {
              setState(() {
                _activeIndex = index;
              });
            },
            unselectedLabelStyle: TextStyle(
              color: ColorConstants.black,
              fontWeight: FontWeight.w600,
            ),
            labelStyle: TextStyle(
              color: ColorConstants.primary,
              fontWeight: FontWeight.w600,
            ),
            indicatorColor: ColorConstants.primary,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            tabs: const [
              Tab(
                text: "Activities",
              ),
              Tab(
                text: "Topics",
              ),
              Tab(
                text: "Information",
              ),
            ],
          ),
        ),
        CustomTabBarView(index: _activeIndex, tabs: _tabs),
      ],
    );
  }
}
