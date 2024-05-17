import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lexa/core/configs/app_localization.dart';
import 'package:lexa/domain/business/blocs/auth.bloc.dart';
import 'package:lexa/domain/business/blocs/chat.bloc.dart';
import 'package:lexa/domain/business/blocs/profile.bloc.dart';
import 'package:lexa/domain/business/events/chat_bloc.event.dart';
import 'package:lexa/domain/business/events/login_bloc.event.dart';
import 'package:lexa/domain/business/events/profile_bloc.event.dart';
import 'package:lexa/domain/business/states/login_bloc.state.dart';
import 'package:lexa/presentation/screens/sign_in_screen.dart';
import 'package:lexa/presentation/screens/intro_screen.dart';
import 'package:flutter/material.dart';
import 'package:lexa/presentation/screens/main_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LaunchPage extends StatefulWidget {
  const LaunchPage({super.key});

  @override
  State<StatefulWidget> createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {
  bool _isFirstLaunch = true;
  late AuthBloc _authBloc;

  void checkFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _isFirstLaunch = prefs.getBool("isFirstLaunch") ?? true;
    });
  }

  @override
  void initState() {
    super.initState();
    _authBloc = context.read<AuthBloc>();
    _authBloc.add(TokenAuth());
    context.read<ProfileBloc>().add(LoadProfile());
    context.read<ChatBloc>().add(ConnectChatServer());
    checkFirstLaunch();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context);

    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state is AuthSuccess) {
        _navigation(const MainPage());
      } else if (state is AuthFail) {
        _navigation(_isFirstLaunch ? const IntroPage() : const SignInScreen());
      }

      return Scaffold(
        body: Container(
          alignment: Alignment.center,
          color: const Color(0xff0961F5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LottieBuilder.asset("assets/animations/launching.json"),
              const SizedBox(
                height: 35,
              ),
              Text(
                appLocalizations.getByKey("welcome_app"),
                style: const TextStyle(
                  fontSize: 40,
                  fontFamily: "Quicksand",
                  fontWeight: FontWeight.bold,
                  color: Color(0xffFFFFFF),
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      );
    });
  }

  void _navigation(Widget toScreen) {
    Timer(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => toScreen,
          transitionDuration: const Duration(milliseconds: 1000),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = 0.0;
            const end = 1.0;
            const curve = Curves.easeInOutQuad;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var opacity = animation.drive(tween);
            return FadeTransition(
              opacity: opacity,
              child: child,
            );
          },
        ),
      );
    });
  }
}
