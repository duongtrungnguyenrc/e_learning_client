import 'package:lexa/core/configs/app_localization.dart';
import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/presentation/shared/widgets/primary_button.dart';
import 'package:lexa/presentation/shared/widgets/find_account_result.dart';
import 'package:lexa/presentation/features/auth/widgets/forgot_password_enter_code_dialog.dart';
import 'package:flutter/material.dart';

class FindAccountPage extends StatefulWidget {
  const FindAccountPage({super.key});

  @override
  State<StatefulWidget> createState() => _FindAccountPageState();
}

class _FindAccountPageState extends State<FindAccountPage> {
  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Find your account",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xff000000),
          ),
        ),
        backgroundColor: ColorConstants.white,
      ),
      body: Container(
          color: ColorConstants.white,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  appLocalizations.getByKey("find_account_heading"),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const FindAccountResult(),
                const SizedBox(
                  height: 30,
                ),
                PrimaryButton(
                  padding: const EdgeInsets.all(15),
                  onPressed: () => _dialogBuilder(context),
                  text: appLocalizations.getByKey("reset_password"),
                ),
              ],
            ),
          )),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return const ForgotPasswordEnterCodeDialog();
      },
    );
  }
}
