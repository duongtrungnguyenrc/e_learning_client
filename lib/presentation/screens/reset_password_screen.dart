// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lexa/data/dtos/destroy_forgot_password.dto.dart';

import 'package:lexa/domain/business/blocs/forgot_password.bloc.dart';
import 'package:lexa/domain/business/blocs/reset_password.bloc.dart';
import 'package:lexa/domain/business/events/forgot_password_bloc.event.dart';
import 'package:lexa/domain/business/events/reset_password_bloc.event.dart';
import 'package:lexa/domain/business/states/reset_password_bloc.state.dart';
import 'package:lexa/presentation/views/auth_text_field.dart';
import 'package:lexa/presentation/views/back_app_bar.dart';
import 'package:lexa/presentation/views/confirm_dialog.dart';
import 'package:lexa/presentation/views/count_down_clock.dart';
import 'package:lexa/presentation/views/primary_button.dart';
import 'package:toastification/toastification.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String id;

  const ResetPasswordScreen(
    this.id, {
    Key? key,
  }) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _otpTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  final TextEditingController _confirmPasswordTextEditingController =
      TextEditingController();

  late ForgotPasswordBloc _forgotPasswordBloc;
  late ResetPasswordBloc _resetPasswordBloc;

  @override
  void initState() {
    super.initState();
    _forgotPasswordBloc = context.read<ForgotPasswordBloc>();
    _resetPasswordBloc = context.read<ResetPasswordBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: BackAppBar(
          title: "Reset password",
          onBack: _onBack,
        ),
        body: _buildResetPasswordForm(),
      ),
    );
  }

  bool _onBack() {
    showDialog(
      context: context,
      builder: (context) => ConfirmDialog(
        action: () {
          _forgotPasswordBloc.add(
            DestroyForgotPasswordTransaction(
              payload: DestroyForgotPasswordTransactionDto(
                transactionId: _forgotPasswordBloc.state.transaction ?? "",
              ),
            ),
          );
          Navigator.pop(context);
        },
        title: "NOTIFICATION",
        message: "If you exit, your OTP will be destroy?",
      ),
    );
    return false;
  }

  Widget _buildResetPasswordForm() {
    return BlocListener<ResetPasswordBloc, ResetPasswordState>(
      listener: (context, state) {
        if (state.errorMessage == null &&
            state.loading == false &&
            state.message != null) {
          toastification.show(
            context: context,
            type: ToastificationType.success,
            style: ToastificationStyle.fillColored,
            title: Text(state.message!),
            alignment: Alignment.bottomCenter,
            animationDuration: const Duration(milliseconds: 300),
            autoCloseDuration: const Duration(milliseconds: 3000),
          );

          Navigator.pop(context);
        }

        if (state.errorMessage != null) {
          toastification.show(
            context: context,
            type: ToastificationType.error,
            style: ToastificationStyle.fillColored,
            title: Text((state.errorMessage ?? "Unknow error")),
            alignment: Alignment.bottomCenter,
            animationDuration: const Duration(milliseconds: 300),
            autoCloseDuration: const Duration(milliseconds: 3000),
          );
        }
      },
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CountDownClock(
                title:
                    "Please check your email to get OTP code, Your OTP code valid in: ",
                interval: const Duration(minutes: 15),
                onDone: () {
                  showDialog(
                    context: context,
                    builder: (context) => ConfirmDialog(
                      action: () {
                        _forgotPasswordBloc.add(
                          CreateForgotPasswordTransaction(userId: widget.id),
                        );
                      },
                      onCancel: () {
                        Navigator.pop(context);
                      },
                      title: "service not available !",
                      message:
                          "OTP is no longer available, Do you want to inherit the transaction?",
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              AuthTextField(
                controller: _otpTextEditingController,
                hintText: "OTP code",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter OTP code";
                  }
                  if (value.length != 6) {
                    return "Please enter full 6 digits";
                  }
                  return null;
                },
                textInputType: TextInputType.phone,
                formats: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(6),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              AuthTextField(
                isPassword: true,
                controller: _passwordTextEditingController,
                hintText: "New password",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter new password";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              AuthTextField(
                isPassword: true,
                controller: _confirmPasswordTextEditingController,
                hintText: "Confirm password",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter confirm password";
                  } else if (value != _passwordTextEditingController.text) {
                    return "Confirm password does not match your password";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
                builder: (context, state) {
                  return PrimaryButton(
                    padding: const EdgeInsets.all(15),
                    onPressed: _onSave,
                    text: "Save password",
                    loading: state.loading,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      _resetPasswordBloc.add(
        ResetPassword(
          _forgotPasswordBloc.state.transaction ?? "",
          _otpTextEditingController.text,
          _passwordTextEditingController.text,
        ),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _forgotPasswordBloc.add(ClearForgotPasswordTransaction());
  }
}
