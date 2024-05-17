import 'package:flutter/material.dart';
import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/core/configs/app_localization.dart';
import 'package:lexa/presentation/views/back_app_bar.dart';

class SettingLanguagePage extends StatelessWidget {
  const SettingLanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: ColorConstants.white,
      appBar: BackAppBar(
        title: appLocalizations.getByKey("language"),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: languages.length,
          itemBuilder: (context, index) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(13),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    languages[index]["name"] ?? "",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Quicksand",
                      color: ColorConstants.black,
                    ),
                  ),
                  Text(
                    languages[index]["nativeName"] ?? "",
                    style: TextStyle(
                      fontSize: 14,
                      color: ColorConstants.primaryGray,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
