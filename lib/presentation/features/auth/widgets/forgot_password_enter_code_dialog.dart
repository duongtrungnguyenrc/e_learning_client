import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/presentation/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class ForgotPasswordEnterCodeDialog extends StatefulWidget {
  const ForgotPasswordEnterCodeDialog({super.key});

  @override
  State<StatefulWidget> createState() => _ForgotPasswordEnterCodeDialogState();
}

class _ForgotPasswordEnterCodeDialogState extends State<ForgotPasswordEnterCodeDialog> {
  final List<FocusNode> _focusNodes = List.generate(5, (index) => FocusNode());
  final List<TextEditingController> _controllers = List.generate(6, (index) => TextEditingController());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorConstants.white,
      surfaceTintColor: ColorConstants.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: IntrinsicHeight(
          child: Column(
            children: [
              const Text(
                "Enter your verification code",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (index) {
                    _focusNodes[0].requestFocus();

                    return Padding(
                      padding: index < 4 ? const EdgeInsets.only(right: 7) : const EdgeInsets.all(0),
                      child: SizedBox(
                        width: 45.0,
                        height: 45.0,
                        child: TextField(
                          controller: _controllers[index],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLength: 1,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              if (index < _controllers.length - 1) {
                                _focusNodes[index].unfocus();
                                _focusNodes[index + 1].requestFocus();
                              }
                            } else {
                              if (index > 0) {
                                _focusNodes[index].unfocus();
                                _focusNodes[index - 1].requestFocus();
                              }
                            }
                          },
                          focusNode: _focusNodes[index],
                          decoration: InputDecoration(
                            counterText: '',
                            contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(width: 1, color: Color.fromARGB(255, 105, 105, 105)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(width: 2, color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      onPressed: () {},
                      text: "Reset password",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
