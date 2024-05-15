import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/domain/business/blocs/profile.bloc.dart';
import 'package:lexa/domain/business/states/profile_bloc.state.dart';
import 'package:lexa/presentation/features/main/tabs/profile_information_tab.dart';
import 'package:lexa/presentation/features/main/tabs/profile_topics_tab.dart';
import 'package:lexa/presentation/features/main/widgets/profile_body.dart';
import 'package:lexa/presentation/shared/widgets/primary_button.dart';
import 'package:lexa/presentation/shared/widgets/profile_overview.dart';
import 'package:flutter/material.dart';
import 'package:lexa/presentation/shared/widgets/svg_icon.dart';

import '../../../../data/models/profile.model.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> with TickerProviderStateMixin {
  late TabController _tabController;
  int activeIndex = 0;
  final tabs = <Widget>[
    Container(),
    const ProfileTopicsTab(),
    const ProfileInformationTab(),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: ColorConstants.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      Profile? profile = state.getAuthenticatedNode();

                      return ProfileOverview(
                        avatarUrl: profile?.avatar,
                        name: profile?.name,
                        followers: profile?.followerCount,
                        topics: profile?.topicCount,
                        archivements: profile?.archivementCount,
                        story: profile?.email,
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: PrimaryButton(
                            icon: SvgIcon(
                              assetUrl: "assets/icons/follow_icon.svg",
                              size: 14,
                              color: ColorConstants.white,
                            ),
                            onPressed: () {},
                            textSize: 14,
                            text: "Follow",
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: PrimaryButton(
                            icon: SvgIcon(
                              assetUrl: "assets/icons/mail_icon.svg",
                              size: 18,
                              color: ColorConstants.black,
                            ),
                            onPressed: () {},
                            text: "Contact",
                            textSize: 14,
                            style: PrimaryButtonStyle.outlined,
                            textColor: ColorConstants.black,
                            backgroundColor: ColorConstants.white,
                            overlayColor: ColorConstants.primaryGrey,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        PrimaryButton(
                          padding: const EdgeInsets.all(10),
                          onPressed: () {},
                          style: PrimaryButtonStyle.outlined,
                          backgroundColor: ColorConstants.white,
                          overlayColor: ColorConstants.primaryGrey,
                          child: SvgIcon(
                            assetUrl: "assets/icons/pen_icon.svg",
                            size: 18,
                            color: ColorConstants.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
            const ProfileBody()
          ],
        ),
      ),
    );
  }
}
