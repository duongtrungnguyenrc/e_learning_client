import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lexa/core/configs/app_localization.dart';
import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/domain/business/blocs/auth.bloc.dart';
import 'package:lexa/domain/business/events/login_bloc.event.dart';
import 'package:lexa/domain/business/states/login_bloc.state.dart';
import 'package:lexa/presentation/screens/sign_up_screen.dart';
import 'package:lexa/presentation/views/auth_bottom.dart';
import 'package:lexa/presentation/views/auth_header.dart';
import 'package:lexa/presentation/views/auth_text_field.dart';
import 'package:lexa/presentation/screens/main_screen.dart';

import 'package:lexa/presentation/views/forgot_password_button.dart';
import 'package:lexa/core/commons/button_size.dart';
import 'package:lexa/presentation/views/primary_button.dart';
import 'package:lexa/presentation/views/error_alert.dart';
import 'package:lexa/presentation/views/loading_dialog.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailTextEditingController = TextEditingController()
    ..text = "duongtrungnguyen00@gmail.com";
  final _passwordTextEditingController = TextEditingController()
    ..text = "nguyendeptrai";

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context);

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          _showLoading(context);
        } else if (state is AuthSuccess) {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MainPage(),
            ),
          );
        } else if (state is AuthFail) {
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (context) => ErrorAlert(
              title: "SignIn fail",
              errors: state.message,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            alignment: Alignment.center,
            color: ColorConstants.white,
            child: PopScope(
              canPop: false,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AuthHeader(
                        heading: appLocalizations.getByKey("sign_in_heading"),
                        subHeading:
                            appLocalizations.getByKey("sign_in_sub_heading"),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Form(
                        child: Column(
                          children: [
                            AuthTextField(
                              controller: _emailTextEditingController,
                              iconPath: "assets/icons/email_icon.svg",
                              hintText: appLocalizations
                                  .getByKey("email_or_username"),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            AuthTextField(
                              onSubmitted: (value) => _handleSignIn(context),
                              controller: _passwordTextEditingController,
                              iconPath: "assets/icons/lock_icon.svg",
                              hintText: appLocalizations.getByKey("password"),
                              isPassword: true,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ForgotPasswordButton(dialogContext: context),
                      const SizedBox(
                        height: 5,
                      ),
                      PrimaryButton(
                        onPressed: () => _handleSignIn(context),
                        size: ButtonSize.expanded,
                        padding: const EdgeInsets.all(10),
                        textSize: 18,
                        text: appLocalizations.getByKey("sign_in"),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      AuthBottom(
                        actionTitle:
                            "${appLocalizations.getByKey("dont_have_account")}?",
                        actionName: appLocalizations.getByKey("sign_up"),
                        action: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  _showLoading(BuildContext context) {
    return showDialog(
      context: context,
      barrierColor: Colors.white,
      builder: (context) {
        return const LoadingDialog();
      },
    );
  }

  _handleSignIn(BuildContext context) {
    final String email = _emailTextEditingController.text;
    final String password = _passwordTextEditingController.text;

    BlocProvider.of<AuthBloc>(context).add(
      DefaultAuth(
        email: email,
        password: password,
      ),
    );
  }
}
