import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/domain/business/blocs/profile.bloc.dart';
import 'package:lexa/domain/business/states/profile_bloc.state.dart';
import 'package:lexa/presentation/screens/sign_in_screen.dart';
import 'package:lexa/presentation/views/setting_group.dart';
import 'package:lexa/presentation/views/setting_item.dart';
import 'package:lexa/presentation/views/confirm_dialog.dart';
import 'package:lexa/presentation/views/profile_overview.dart';
import 'package:lexa/domain/utils/icon_style.utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingTab extends StatefulWidget {
  const SettingTab({super.key});

  @override
  State<SettingTab> createState() => _SettingTabState();
}

class _SettingTabState extends State<SettingTab> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      return SafeArea(
        child: Container(
          color: ColorConstants.white,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                decoration: BoxDecoration(
                    color: ColorConstants.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 1,
                      color: ColorConstants.primaryGrey,
                    )),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ProfileOverview(
                    avatarUrl: state.getAuthenticatedNode()?.avatar,
                    name: state.getAuthenticatedNode()?.name,
                    story: state.getAuthenticatedNode()?.email,
                    topics: state.getAuthenticatedNode()?.topicCount,
                    followers: state.getAuthenticatedNode()?.followerCount,
                    archivements:
                        state.getAuthenticatedNode()?.archivementCount,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: ListView.builder(
                    itemCount: SettingItemConstant.items.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return SettingsGroup(
                        settingsGroupTitle:
                            SettingItemConstant.items[index].title,
                        items: List.generate(
                          SettingItemConstant.items[index].items.length,
                          (idx) => SettingsItem(
                            onTap: () {
                              final navigationScreen = SettingItemConstant
                                  .items[index].items[idx].navigation;

                              if (navigationScreen != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => navigationScreen),
                                );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) => ConfirmDialog(
                                    action: () async {
                                      SharedPreferences sharedPreferences =
                                          await SharedPreferences.getInstance();
                                      sharedPreferences.remove("access_token");
                                      _logOut();
                                    },
                                    title: "Log out",
                                    message: "Do you want log out?",
                                  ),
                                );
                              }
                            },
                            subtitleMaxLine: 1,
                            assetUrl: SettingItemConstant
                                .items[index].items[idx].iconUrl,
                            title: SettingItemConstant
                                .items[index].items[idx].title,
                            subtitle: SettingItemConstant
                                .items[index].items[idx].subtitle,
                            iconStyle: IconStyle(
                              backgroundColor: SettingItemConstant
                                  .items[index].items[idx].iconBackground,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  void _logOut() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => const SignInScreen()),
      ),
    );
  }
}
