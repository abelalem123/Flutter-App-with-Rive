import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rive_animation/screens/onboding/components/sign_in_form.dart';

Future<Object?> customSigninDialogue(BuildContext context,
    {required ValueChanged onClosed}) {
  return showGeneralDialog(
    barrierLabel: "Sign In",
    barrierDismissible: true,
    context: context,
    transitionDuration: Duration(milliseconds: 400),
    transitionBuilder: (_, animation, __, child) {
      Tween<Offset> tween;
      tween = Tween(begin: const Offset(0, -1), end: Offset.zero);
      return SlideTransition(
        position: tween.animate(
          CurvedAnimation(parent: animation, curve: Curves.easeInOut),
        ),
        child: child,
      );
    },
    pageBuilder: (context, _, __) {
      return Center(
        child: Container(
          height: 620,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.94),
              borderRadius: BorderRadius.all(Radius.circular(40))),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Column(
                    children: [
                      Text(
                        "Sign In",
                        style: TextStyle(fontSize: 34, fontFamily: "Poppins"),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                            "purchase includes access to 30+ courses, 240+ premium tutorials, 120+ hours of videos, source files and certificates"),
                      ),
                      SignInForm(),
                      Row(
                        children: const [
                          Expanded(
                              child: Divider(
                            color: Colors.black26,
                          )),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              "OR",
                              style: TextStyle(color: Colors.black26),
                            ),
                          ),
                          Expanded(child: Divider()),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          "Sign up with Email, Apple or Google",
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {},
                              icon: SvgPicture.asset(
                                'assets/icons/email_box.svg',
                                height: 64,
                                width: 64,
                              )),
                          IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {},
                              icon: SvgPicture.asset(
                                'assets/icons/apple_box.svg',
                                height: 64,
                                width: 64,
                              )),
                          IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {},
                              icon: SvgPicture.asset(
                                'assets/icons/google_box.svg',
                                height: 64,
                                width: 64,
                              )),
                        ],
                      )
                    ],
                  ),
                  const Positioned(
                    right: 0,
                    left: 0,
                    bottom: -78,
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    },
  ).then(onClosed);
}
