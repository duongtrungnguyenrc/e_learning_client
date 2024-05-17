import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/presentation/screens/sign_in_screen.dart';
import 'package:lexa/presentation/views/intro_step.dart';
import 'package:lexa/presentation/views/start_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  int activeTab = 0;
  final PageController controller = PageController();

  void changeTab(int tab) {
    setState(() {
      activeTab = tab;
    });
  }

  void handleNextStep() async {
    if (activeTab >= 2) {
      handleFirstLaunch();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        ),
      );
    } else {
      changeTab(activeTab + 1);
      controller.animateToPage(
        activeTab,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void handleFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("isFirstLaunch", false);
  }

  void onSkipPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: onSkipPressed,
            child: const Text(
              "Skip",
              style: TextStyle(
                color: Color(0xff000000),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          )
        ],
        backgroundColor: ColorConstants.lightGrey,
      ),
      body: Container(
        color: ColorConstants.lightGrey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: PageView(
                controller: controller,
                onPageChanged: changeTab,
                children: const [
                  IntroStep(
                    title: "Online Learning",
                    subtitle:
                        "We Provide Classes Online Classes and Pre Recorded Leactures.!",
                    thumbnailSrc: "assets/images/online_learning.png",
                  ),
                  IntroStep(
                    title: "Learn from Anytime",
                    subtitle: "Booked or Same the Lectures for Future",
                    thumbnailSrc: "assets/images/learn_anytime.png",
                  ),
                  IntroStep(
                    title: "Get Online Certificate",
                    subtitle: "Analyse your scores and Track your results",
                    thumbnailSrc: "assets/images/get_certificate.png",
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmoothPageIndicator(
                    controller: controller,
                    count: 3,
                    textDirection: TextDirection.ltr,
                    effect: ExpandingDotsEffect(
                      dotWidth: 10,
                      dotHeight: 10,
                      activeDotColor: ColorConstants.primary,
                      expansionFactor: 2,
                    ),
                  ),
                  StartButton(
                    isActive: activeTab == 2,
                    action: handleNextStep,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
