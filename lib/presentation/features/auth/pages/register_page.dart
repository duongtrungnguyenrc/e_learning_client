import 'package:lexa/core/configs/app_localization.dart';
import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/presentation/features/auth/widgets/auth_bottom.dart';
import 'package:lexa/presentation/features/auth/widgets/auth_heading.dart';
import 'package:lexa/presentation/features/auth/widgets/auth_text_field.dart';
import 'package:lexa/presentation/features/auth/pages/login_page.dart';
import 'package:lexa/presentation/shared/widgets/primary_button.dart';
import 'package:lexa/presentation/features/auth/widgets/forgot_password_button.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: ColorConstants.white,
          height: MediaQuery.of(context).size.height,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AuthHeading(
                    heading: appLocalizations.getByKey("sign_up_heading"),
                    subHeading: appLocalizations.getByKey("sign_up_sub_heading"),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Column(
                    children: [
                      AuthTextField(
                        onChanged: (value) {},
                        hintText: appLocalizations.getByKey("full_name"),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AuthTextField(
                        onChanged: (value) {},
                        hintText: "Email",
                        iconPath: "assets/icons/email_icon.svg",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AuthTextField(
                        onChanged: (value) {},
                        hintText: appLocalizations.getByKey("phone"),
                        iconPath: "assets/icons/phone_icon.svg",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: AuthTextField(
                              onChanged: (value) {},
                              hintText: appLocalizations.getByKey("password"),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: AuthTextField(
                              onChanged: (value) {},
                              hintText: appLocalizations.getByKey("confirm_password"),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ForgotPasswordButton(dialogContext: context),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: PrimaryButton(
                              onPressed: () {},
                              text: appLocalizations.getByKey("sign_up"),
                              padding: const EdgeInsets.all(13),
                              textSize: 20,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      AuthBottom(
                        actionName: appLocalizations.getByKey("sign_in"),
                        action: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
