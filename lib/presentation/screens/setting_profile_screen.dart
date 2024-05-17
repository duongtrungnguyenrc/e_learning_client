import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/domain/business/blocs/profile.bloc.dart';
import 'package:lexa/domain/business/states/profile_bloc.state.dart';
import 'package:lexa/presentation/views/form_text_field.dart';
import 'package:lexa/presentation/views/back_app_bar.dart';
import 'package:lexa/presentation/views/circular_icon_button.dart';
import 'package:lexa/presentation/views/primary_button.dart';

class SettingProfilePage extends StatefulWidget {
  const SettingProfilePage({super.key});

  @override
  State<SettingProfilePage> createState() => _SettingProfilePageState();
}

class _SettingProfilePageState extends State<SettingProfilePage> {
  bool isEdit = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      return Scaffold(
        backgroundColor: ColorConstants.white,
        appBar: const BackAppBar(
          title: "Personal information",
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Stack(
                  children: [
                    ClipOval(
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width / 3,
                        height: MediaQuery.of(context).size.width / 3,
                        imageUrl: state.getAuthenticatedNode()?.avatar ?? "",
                        errorWidget: (context, url, error) => Image.asset("assets/images/user.jpg"),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircularIconButton(
                        iconPath: "assets/icons/pen_icon.svg",
                        size: 30,
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Form(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      FormTextField(
                        maxLines: 1,
                        hintText: "Name",
                        initialValue: state.getAuthenticatedNode()?.name,
                        enabled: isEdit,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      FormTextField(
                        maxLines: 1,
                        hintText: "Email",
                        initialValue: state.getAuthenticatedNode()?.email,
                        enabled: isEdit,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      FormTextField(
                        maxLines: 1,
                        hintText: "Phone",
                        initialValue: state.getAuthenticatedNode()?.phone,
                        enabled: isEdit,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    onPressed: () {
                      setState(() {
                        isEdit = !isEdit;
                      });
                    },
                    text: "Edit",
                    style: PrimaryButtonStyle.outlined,
                    textColor: Colors.black,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: PrimaryButton(
                    onPressed: () {},
                    text: "Save",
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
