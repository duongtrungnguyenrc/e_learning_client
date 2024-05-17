import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/presentation/views/first_step_setup_language_option.dart';
import 'package:lexa/presentation/views/first_step_setup_priority_topic_option.dart';
import 'package:lexa/presentation/views/first_step_setup_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FirstStepSetupPage extends StatefulWidget {
  const FirstStepSetupPage({super.key});

  @override
  State<StatefulWidget> createState() => _FirstStepSetupPage();
}

class _FirstStepSetupPage extends State<FirstStepSetupPage> {
  final List<String> languages = [
    'English',
    'Spanish',
    'French',
    'German',
    'Chinese',
    'Japanese',
    'Korean',
    'Arabic',
    'Russian',
    'Portuguese',
    'Italian',
    'Vietnamese',
    'Hindi',
    'Bengali',
    'Urdu',
  ];

  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    // controller.animateTo(2, duration: Duration(seconds: 5), curve: Curves.linear);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: SvgPicture.asset(
            "assets/icons/arrow_back_icon.svg",
          ),
        ),
        leadingWidth: 45,
        actions: const [
          Text(
            "1/2",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(
            width: 15,
          )
        ],
      ),
      body: Container(
        color: ColorConstants.white,
        child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
            child: Column(
              children: [
                LinearProgressIndicator(
                  value: 0.5,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(ColorConstants.primary),
                  minHeight: 10,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: PageView(
                    controller: controller,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      FirstStepSetupStep<String, FirstStepSetupLanguageOption>(
                          items: languages,
                          heading: "What's your native language?",
                          subHeading: "Vocab master use your mother language to provide app locale."),
                      FirstStepSetupStep<String, FirstStepSetupPriorityTopicOption>(
                          items: languages,
                          heading: "What's your native language??",
                          subHeading: "Vocab master use your mother language to provide app locale."),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
