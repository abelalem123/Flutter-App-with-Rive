import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rive/rive.dart';

import 'components/animated_btn.dart';
import 'components/custom_signin_dialogue.dart';
import 'components/sign_in_form.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late RiveAnimationController _btnAnimationController;
  bool isSignInDialogueShown = false;

  @override
  void initState() {
    _btnAnimationController = OneShotAnimation('active', autoplay: false);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              bottom: 100,
              left: 100,
              width: MediaQuery.of(context).size.width * 1.7,
              child: Image.asset('assets/Backgrounds/Spline.png')),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10,
                sigmaY: 10,
              ),
            ),
          ),
          RiveAnimation.asset('assets/RiveAssets/shapes.riv'),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 30,
                sigmaY: 30,
              ),
              child: SizedBox(),
            ),
          ),
          AnimatedPositioned(
            top: isSignInDialogueShown ? -50 : 0,
            duration: Duration(milliseconds: 240),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SafeArea(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(),
                  SizedBox(
                    width: 260,
                    child: Column(
                      children: const [
                        Text(
                          'Learn design & code',
                          style: TextStyle(
                              fontSize: 70, fontFamily: "Poppins", height: 1.2),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                            "Don't skip design. Learn design and code, by building  real apps with Flutter and Swift. Complete courses about the best tools.")
                      ],
                    ),
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                  AnimatedBtn(
                    btnAnimationController: _btnAnimationController,
                    press: () {
                      _btnAnimationController.isActive = true;
                      Future.delayed(Duration(milliseconds: 800), () {
                        setState(() {
                          isSignInDialogueShown = true;
                        });
                        customSigninDialogue(
                          context,
                          onClosed: (_) {
                            setState(() {
                              isSignInDialogueShown = false;
                            });
                          },
                        );
                      });
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Text(
                        "purchase includes access to 30+ courses, 240+ premium tutorials, 120+ hours of videos, source files and certificates"),
                  )
                ],
              ),
            )),
          )
        ],
      ),
    );
  }
}
