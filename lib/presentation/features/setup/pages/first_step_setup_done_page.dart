import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/presentation/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FirstStepSetupDonePage extends StatefulWidget {
  const FirstStepSetupDonePage({super.key});

  @override
  State<StatefulWidget> createState() => _FirstStepSetupDonePageState();
}

class _FirstStepSetupDonePageState extends State<FirstStepSetupDonePage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeInAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: ColorConstants.white,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              "assets/animations/success.json",
              width: 200,
              height: 200,
              repeat: false,
            ),
            const Text(
              "All done!",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            FadeTransition(
              opacity: _fadeInAnimation,
              child: PrimaryButton(
                onPressed: () {},
                text: "Continue",
                textSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
