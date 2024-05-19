import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lexa/core/commons/button_size.dart';
import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/domain/business/blocs/find_account.bloc.dart';
import 'package:lexa/domain/business/events/find_account_bloc.event.dart';
import 'package:lexa/domain/business/states/find_account_bloc.state.dart';
import 'package:lexa/presentation/screens/find_accout_screen.dart';
import 'package:lexa/presentation/views/auth_text_field.dart';
import 'package:flutter/material.dart';
import 'package:lexa/presentation/views/primary_button.dart';

class ForgotPasswordDialog extends StatefulWidget {
  const ForgotPasswordDialog({super.key});

  @override
  State<ForgotPasswordDialog> createState() => _ForgotPasswordDialogState();
}

class _ForgotPasswordDialogState extends State<ForgotPasswordDialog> {
  final _formKey = GlobalKey<FormState>();
  late final FindAccountBloc _findAccountBloc;
  final TextEditingController _keyTextEditingController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _findAccountBloc = context.read<FindAccountBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FindAccountBloc, FindAccountState>(
      listener: (context, state) {
        if (state.loading == false &&
            state.exception == null &&
            state.users != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const FindAccountPage(),
            ),
          );
        }
      },
      child: BlocBuilder<FindAccountBloc, FindAccountState>(
        builder: (context, state) {
          return Dialog(
            backgroundColor: ColorConstants.white,
            surfaceTintColor: ColorConstants.white,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: IntrinsicHeight(
                child: Form(
                  key: _formKey,
                  child: Column(children: [
                    const Text(
                      "Find your account",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AuthTextField(
                      isLoading:
                          state.exception == null ? state.loading : false,
                      controller: _keyTextEditingController,
                      hintText: "Email, phone or account id",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter email or phone';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: PrimaryButton(
                            onPressed: () => _onFindAccount(),
                            text: "Find account",
                            size: ButtonSize.expanded,
                            padding: const EdgeInsets.all(10),
                            textSize: 18,
                          ),
                        ),
                      ],
                    )
                  ]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _onFindAccount() {
    if (_formKey.currentState!.validate()) {
      _findAccountBloc.add(
        FindAccount(key: _keyTextEditingController.text),
      );
    }
  }
}
