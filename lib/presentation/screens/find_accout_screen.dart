import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lexa/core/configs/app_localization.dart';
import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/data/models/user.model.dart';
import 'package:lexa/domain/business/blocs/find_account.bloc.dart';
import 'package:lexa/domain/business/blocs/forgot_password.bloc.dart';
import 'package:lexa/domain/business/events/find_account_bloc.event.dart';
import 'package:lexa/domain/business/events/forgot_password_bloc.event.dart';
import 'package:lexa/domain/business/states/find_account_bloc.state.dart';
import 'package:lexa/domain/business/states/forgot_password_state.dart';
import 'package:lexa/presentation/screens/reset_password_screen.dart';
import 'package:lexa/presentation/views/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class FindAccountPage extends StatefulWidget {
  const FindAccountPage({super.key});

  @override
  State<StatefulWidget> createState() => _FindAccountPageState();
}

class _FindAccountPageState extends State<FindAccountPage> {
  late final FindAccountBloc _findAccountBloc;
  late final ForgotPasswordBloc _forgotPasswordBloc;
  int? _selectedUserIndex;

  @override
  void initState() {
    super.initState();
    _findAccountBloc = context.read<FindAccountBloc>();
    _forgotPasswordBloc = context.read<ForgotPasswordBloc>();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context);

    return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        if (state is TransactionState && state.transaction != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ResetPasswordScreen(
                _findAccountBloc.state.users![_selectedUserIndex!].id,
              ),
            ),
          );
        }
      },
      child: Scaffold(
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
            child: BlocBuilder<FindAccountBloc, FindAccountState>(builder: (context, state) {
              return Column(
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
                  ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 15,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.users?.length ?? 0,
                    itemBuilder: (_, index) => _foundUserItem(state.users![index], index),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  PrimaryButton(
                    size: double.infinity,
                    padding: const EdgeInsets.all(15),
                    onPressed: _onResetPassword,
                    text: appLocalizations.getByKey("reset_password"),
                    loading: state.loading,
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _foundUserItem(User user, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          if (_selectedUserIndex == index) {
            _selectedUserIndex = null;
          } else {
            _selectedUserIndex = index;
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: _selectedUserIndex == index ? ColorConstants.primary : const Color.fromRGBO(0, 0, 0, 0.15),
              offset: const Offset(0, 0),
              blurRadius: 10.0,
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: Row(
            children: [
              Container(
                width: 48.0,
                height: 48.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(
                    color: ColorConstants.black,
                    width: 1.0,
                  ),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/icons/email_icon.svg",
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Via Email",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    user.email,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onResetPassword() {
    if (_selectedUserIndex != null) {
      _forgotPasswordBloc.add(
        CreateForgotPasswordTransaction(
          userId: _findAccountBloc.state.users![_selectedUserIndex!].id,
        ),
      );
    } else {
      toastification.show(
        context: context,
        type: ToastificationType.error,
        style: ToastificationStyle.fillColored,
        title: const Text("Please choose your account"),
        alignment: Alignment.bottomCenter,
        animationDuration: const Duration(milliseconds: 300),
        autoCloseDuration: const Duration(milliseconds: 3000),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _findAccountBloc.add(ClearFoundAccounts());
  }
}
