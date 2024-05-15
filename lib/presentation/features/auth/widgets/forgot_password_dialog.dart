import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/presentation/features/auth/pages/find_accout_page.dart';
import 'package:lexa/presentation/features/auth/widgets/auth_text_field.dart';
import 'package:flutter/material.dart';
import 'package:lexa/presentation/shared/widgets/primary_button.dart';

class ForgotPasswordDialog extends StatelessWidget {
  const ForgotPasswordDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorConstants.white,
      surfaceTintColor: ColorConstants.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: IntrinsicHeight(
          child: Column(children: [
            const Text(
              "Find your account",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            AuthTextField(
              hintText: "Email",
              onChanged: (value) {},
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    padding: const EdgeInsets.all(15),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FindAccountPage(),
                        ),
                      );
                    },
                    child: const Text(
                      "Find account",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xffFFFFFF),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
