import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lexa/core/commons/theme.dart';
import 'package:lexa/core/configs/app_localization_delegrate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lexa/domain/business/blocs/chat.bloc.dart';
import 'package:lexa/domain/business/blocs/find_account.bloc.dart';
import 'package:lexa/domain/business/blocs/forgot_password.bloc.dart';
import 'package:lexa/domain/business/blocs/home.bloc.dart';
import 'package:lexa/domain/business/blocs/auth.bloc.dart';
import 'package:lexa/domain/business/blocs/learning.bloc.dart';
import 'package:lexa/domain/business/blocs/learning_summary.bloc.dart';
import 'package:lexa/domain/business/blocs/offline_data.bloc.dart';
import 'package:lexa/domain/business/blocs/reset_password.bloc.dart';
import 'package:lexa/domain/business/blocs/search.bloc.dart';
import 'package:lexa/domain/business/blocs/topic.bloc.dart';
import 'package:lexa/domain/business/blocs/update_profile.bloc.dart';
import 'package:lexa/presentation/screens/launch_screen.dart';
import 'package:lexa/domain/business/blocs/profile.bloc.dart';
import 'package:lexa/domain/business/blocs/create_topic.bloc.dart';
import 'package:lexa/domain/business/blocs/manage_topic.bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => UpdateProfileBloc(),
        ),
        BlocProvider(
          create: (_) => FindAccountBloc(),
        ),
        BlocProvider(
          create: (_) => ForgotPasswordBloc(),
        ),
        BlocProvider(
          create: (_) => ResetPasswordBloc(),
        ),
        BlocProvider(
          create: (_) => LearningSummaryBloc(),
        ),
        BlocProvider(
          create: (_) => LearningBloc(),
        ),
        BlocProvider(
          create: (_) => OfflineDataBloc(),
        ),
        BlocProvider(
          create: (_) => AuthBloc(),
        ),
        BlocProvider(
          create: (_) => CreateTopicBloc(),
        ),
        BlocProvider(
          create: (context) => ManageTopicBloc(
            context.read<CreateTopicBloc>(),
          ),
        ),
        BlocProvider(
          create: (_) => ProfileBloc(),
        ),
        BlocProvider(
          create: (_) => Homebloc(),
        ),
        BlocProvider(
          create: (context) => TopicBloc(context.read<OfflineDataBloc>()),
        ),
        BlocProvider(
          create: (_) => ChatBloc(),
        ),
        BlocProvider(
          create: (_) => SearchBloc(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeController.getAppTheme(ThemeMode.light),
        title: 'Lexa',
        localizationsDelegates: const [
          AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''),
          Locale('vi', ''),
        ],
        debugShowCheckedModeBanner: false,
        locale: const Locale("en"),
        home: const LaunchPage(),
      ),
    );
  }
}
