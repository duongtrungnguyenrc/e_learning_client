import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/data/dtos/update_profile.dto.dart';
import 'package:lexa/domain/business/blocs/profile.bloc.dart';
import 'package:lexa/domain/business/blocs/update_profile.bloc.dart';
import 'package:lexa/domain/business/events/profile_bloc.event.dart';
import 'package:lexa/domain/business/events/update_profile_bloc.event.dart';
import 'package:lexa/domain/business/states/profile_bloc.state.dart';
import 'package:lexa/domain/business/states/update_profile_bloc.state.dart';
import 'package:lexa/presentation/views/form_text_field.dart';
import 'package:lexa/presentation/views/back_app_bar.dart';
import 'package:lexa/presentation/views/circular_icon_button.dart';
import 'package:lexa/presentation/views/primary_button.dart';
import 'package:toastification/toastification.dart';

class SettingProfilePage extends StatefulWidget {
  const SettingProfilePage({super.key});

  @override
  State<SettingProfilePage> createState() => _SettingProfilePageState();
}

class _SettingProfilePageState extends State<SettingProfilePage> {
  bool isEdit = false;
  late final UpdateProfileBloc _updateProfileBloc;
  late final ProfileBloc _profilebloc;
  final TextEditingController _nameTextEditingController =
      TextEditingController();
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _phoneTextEditingController =
      TextEditingController();

  @override
  initState() {
    super.initState();
    _updateProfileBloc = context.read<UpdateProfileBloc>();
    _profilebloc = context.read<ProfileBloc>();

    final profile = _profilebloc.state.getAuthenticatedNode();
    if (profile != null) {
      _nameTextEditingController.text = profile.name;
      _emailTextEditingController.text = profile.email;
      _phoneTextEditingController.text = profile.phone;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateProfileBloc, UpdateProfileState>(
      listener: ((context, state) {
        if (state.newProfile != null) {
          _profilebloc.add(UpdateSystemProfile(state.newProfile!));
          toastification.show(
            context: context,
            type: ToastificationType.success,
            style: ToastificationStyle.fillColored,
            title: const Text("Update profile success"),
            alignment: Alignment.bottomCenter,
            animationDuration: const Duration(milliseconds: 300),
            autoCloseDuration: const Duration(milliseconds: 3000),
          );
        }
        if (state.loading == false &&
            state.errorMessage != null &&
            state.newProfile == null) {
          toastification.show(
            context: context,
            type: ToastificationType.error,
            style: ToastificationStyle.fillColored,
            title: const Text("Update profile failed"),
            alignment: Alignment.bottomCenter,
            animationDuration: const Duration(milliseconds: 300),
            autoCloseDuration: const Duration(milliseconds: 3000),
          );
        }
        if (state.loading == false &&
            state.errorMessage != null &&
            state.newProfile == null) {
          debugPrint(state.errorMessage);
        }
      }),
      child: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
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
                          errorWidget: (context, url, error) =>
                              Image.asset("assets/images/user.jpg"),
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
                          controller: _nameTextEditingController,
                          maxLines: 1,
                          hintText: "Name",
                          enabled: isEdit,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        FormTextField(
                          controller: _emailTextEditingController,
                          maxLines: 1,
                          hintText: "Email",
                          enabled: isEdit,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        FormTextField(
                          controller: _phoneTextEditingController,
                          maxLines: 1,
                          hintText: "Phone",
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
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
                      onPressed: _onSave,
                      text: "Save",
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  void _onSave() {
    _updateProfileBloc.add(
      UpdateProfile(
        UpdateProfileDto(
          email: _emailTextEditingController.text.isNotEmpty
              ? _emailTextEditingController.text
              : null,
          name: _nameTextEditingController.text.isNotEmpty
              ? _nameTextEditingController.text
              : null,
          phone: _phoneTextEditingController.text.isNotEmpty
              ? _phoneTextEditingController.text
              : null,
        ),
      ),
    );
  }
}
