import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lexa/core/configs/app_localization.dart';
import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/domain/business/blocs/auth.bloc.dart';
import 'package:lexa/domain/business/events/login_bloc.event.dart';
import 'package:lexa/domain/business/states/login_bloc.state.dart';
import 'package:lexa/presentation/views/circular_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';

enum ThirdPartyMethod { google, apple, facebook }

class AuthBottom extends StatefulWidget {
  final String actionName;
  final String actionTitle;
  final VoidCallback action;

  const AuthBottom({
    super.key,
    required this.actionName,
    required this.action,
    required this.actionTitle,
  });

  @override
  State<AuthBottom> createState() => _AuthBottomState();
}

class _AuthBottomState extends State<AuthBottom> {
  @override
  void initState() {
    super.initState();
    initUniLinks();
  }

  Future<void> initUniLinks() async {
    uriLinkStream.listen((Uri? uri) async {
      if (!mounted || uri == null) return;
      context.read<AuthBloc>().add(GoogleAuthResponse(uri: uri));
    }, onError: (err) {
      if (!mounted) return;
      debugPrint(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context);

    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      return Column(
        children: [
          Text(
            appLocalizations.getByKey("or_continue_with"),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              fontFamily: "Mulish",
              color: ColorConstants.black,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularIconButton(
                iconPath: "assets/icons/google_icon.svg",
                size: 48,
                iconSize: 20,
                onTap: _launchURL,
              ),
              const SizedBox(
                width: 30,
              ),
              CircularIconButton(
                iconPath: "assets/icons/facebook_icon.svg",
                size: 48,
                iconSize: 20,
                onTap: () => {},
              ),
              const SizedBox(
                width: 30,
              ),
              CircularIconButton(
                iconPath: "assets/icons/apple_icon.svg",
                size: 48,
                iconSize: 20,
                onTap: () {},
              )
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.actionTitle,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: ColorConstants.primaryGray,
                ),
              ),
              const SizedBox(
                width: 3,
              ),
              GestureDetector(
                onTap: () {
                  widget.action();
                },
                child: Text(
                  widget.actionName.toUpperCase(),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[700],
                  ),
                ),
              )
            ],
          ),
        ],
      );
    });
  }

  void _launchURL() async {
    try {
      await launchUrl(
        Uri.parse(
          "${dotenv.env['SERVER_HOST']}:${dotenv.env['SERVER_PORT']}/api/auth/google-auth",
        ),
        customTabsOptions: CustomTabsOptions(
          colorSchemes: CustomTabsColorSchemes.defaults(
            toolbarColor: Colors.grey[100],
          ),
          shareState: CustomTabsShareState.on,
          urlBarHidingEnabled: true,
          showTitle: true,
          closeButton: CustomTabsCloseButton(
            icon: CustomTabsCloseButtonIcons.back,
          ),
          browser: const CustomTabsBrowserConfiguration(
            prefersDefaultBrowser: true,
          ),
        ),
        safariVCOptions: SafariViewControllerOptions(
          preferredBarTintColor: Colors.grey[100],
          preferredControlTintColor: Colors.black,
          barCollapsingEnabled: true,
          dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
        ),
        prefersDeepLink: true,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
