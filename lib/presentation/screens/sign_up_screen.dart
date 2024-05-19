import 'package:dio/dio.dart';
import 'package:lexa/core/commons/button_size.dart';
import 'package:lexa/core/configs/app_localization.dart';
import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/data/dtos/sign_up_request.dto.dart';
import 'package:lexa/domain/repositories/user.repository.dart';
import 'package:lexa/presentation/views/auth_bottom.dart';
import 'package:lexa/presentation/views/auth_header.dart';
import 'package:lexa/presentation/views/auth_text_field.dart';
import 'package:lexa/presentation/screens/sign_in_screen.dart';
import 'package:lexa/presentation/views/primary_button.dart';
import 'package:lexa/presentation/views/forgot_password_button.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _loginNavigation() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        ),
      );
    }
  }

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
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AuthHeader(
                      heading: appLocalizations.getByKey(
                        "sign_up_heading",
                      ),
                      subHeading: appLocalizations.getByKey(
                        "sign_up_sub_heading",
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Column(
                      children: [
                        AuthTextField(
                          controller: _nameController,
                          onChanged: (value) {},
                          hintText: appLocalizations.getByKey("full_name"),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        AuthTextField(
                          controller: _emailController,
                          onChanged: (value) {},
                          hintText: "Email",
                          iconPath: "assets/icons/email_icon.svg",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            // if (!EmailValidator.validate(value)) {
                            //   return 'Please enter a valid email';
                            // }
                            return null;
                          },
                          textInputType: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        AuthTextField(
                          controller: _phoneController,
                          onChanged: (value) {},
                          hintText: appLocalizations.getByKey("phone"),
                          iconPath: "assets/icons/phone_icon.svg",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: AuthTextField(
                                isPassword: true,
                                controller: _passwordController,
                                onChanged: (value) {},
                                hintText: appLocalizations.getByKey("password"),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a password';
                                  }
                                  if (value.length < 6) {
                                    return 'Password must be at least 6 characters long';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: AuthTextField(
                                isPassword: true,
                                hintText: appLocalizations.getByKey(
                                  "confirm_password",
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please confirm your password';
                                  }
                                  if (value != _passwordController.text) {
                                    return 'Passwords do not match';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        ForgotPasswordButton(dialogContext: context),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: PrimaryButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _submitForm();
                                  }
                                },
                                text: appLocalizations.getByKey("sign_up"),
                                size: ButtonSize.expanded,
                                padding: const EdgeInsets.all(10),
                                textSize: 18,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        AuthBottom(
                          actionTitle:
                              "${appLocalizations.getByKey("already_have_account")}?",
                          actionName: appLocalizations.getByKey("sign_in"),
                          action: _loginNavigation,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    final String name = _nameController.text.trim();
    final String email = _emailController.text.trim();
    final String phone = _phoneController.text.trim();
    final String password = _passwordController.text;

    UserRepository.signUp(SignUpRequestDto(name, email, password, phone)).then(
      (response) {
        _nameController.dispose();
        _emailController.dispose();
        _passwordController.dispose();
        _phoneController.dispose();

        toastification.show(
          context: context,
          type: ToastificationType.success,
          style: ToastificationStyle.fillColored,
          title: Text(response.message),
          alignment: Alignment.bottomCenter,
          animationDuration: const Duration(milliseconds: 300),
          autoCloseDuration: const Duration(milliseconds: 3000),
        );

        _loginNavigation();
      },
    ).onError((DioException e, stackTrace) {
      toastification.show(
        context: context,
        type: ToastificationType.error,
        style: ToastificationStyle.fillColored,
        title: Text(
          e.response?.data['message'] ?? e.message ?? e.stackTrace.toString(),
        ),
        alignment: Alignment.bottomCenter,
        animationDuration: const Duration(milliseconds: 300),
        autoCloseDuration: const Duration(milliseconds: 3000),
      );
    });
  }
}
