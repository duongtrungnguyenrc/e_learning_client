import 'package:lexa/core/configs/app_localization.dart';
import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/presentation/features/auth/widgets/forgot_password_dialog.dart';
import 'package:flutter/material.dart';

class ForgotPasswordButton extends StatelessWidget {
  final BuildContext dialogContext;
  const ForgotPasswordButton({
    super.key,
    required this.dialogContext,
  });

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(dialogContext);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () => _dialogBuilder(context),
          child: Text(
            "${appLocalizations.getByKey("forgot_password")}?",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: ColorConstants.primaryGray,
              fontFamily: "Mulish",
            ),
          ),
        )
      ],
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return const ForgotPasswordDialog();
      },
    );
  }
}
