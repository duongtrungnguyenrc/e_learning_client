import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/data/models/profile.model.dart';
import 'package:lexa/domain/business/blocs/profile.bloc.dart';
import 'package:lexa/domain/business/events/profile_bloc.event.dart';
import 'package:lexa/domain/business/states/profile_bloc.state.dart';
import 'package:lexa/presentation/screens/chat_screen.dart';
import 'package:lexa/presentation/views/profile_body.dart';
import 'package:lexa/presentation/views/back_app_bar.dart';
import 'package:lexa/presentation/views/primary_button.dart';
import 'package:lexa/presentation/views/profile_overview.dart';
import 'package:flutter/material.dart';
import 'package:lexa/presentation/views/svg_icon.dart';

class ProfilePage extends StatefulWidget {
  final String id;

  const ProfilePage({
    super.key,
    required this.id,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late ProfileBloc _profileBloc;

  @override
  void initState() {
    super.initState();
    _profileBloc = context.read<ProfileBloc>();
    _profileBloc.add(LoadProfile(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      final Profile? profile = state.getNode(widget.id);

      return Hero(
        tag: "profile${profile?.id}",
        child: Scaffold(
          body: SafeArea(
            child: Wrap(
              children: [
                const BackAppBar(title: "Profile"),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        color: ColorConstants.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ProfileOverview(
                              avatarUrl: profile?.avatar,
                              name: profile?.name,
                              followers: profile?.followerCount,
                              topics: profile?.topicCount,
                              archivements: profile?.archivementCount,
                              story: profile?.email,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              color: ColorConstants.white,
                              padding:
                                  const EdgeInsets.only(left: 15, right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: PrimaryButton(
                                      prefix: SvgIcon(
                                        assetUrl:
                                            "assets/icons/follow_icon.svg",
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
                                      prefix: SvgIcon(
                                        assetUrl: "assets/icons/mail_icon.svg",
                                        size: 18,
                                        color: ColorConstants.black,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const ChatScreen(),
                                          ),
                                        );
                                      },
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
                            ProfileBody(id: widget.id),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _profileBloc.add(ClearProfile());
  }
}
