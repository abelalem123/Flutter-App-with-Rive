import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:rive_animation/constants.dart';
import 'package:rive_animation/utils/rive_utils.dart';

import 'components/animated_bar.dart';
import 'components/side_menu.dart';
import 'models/menu_btn.dart';
import 'models/rive_assets.dart';
import 'screens/home/home_screen.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint>
    with SingleTickerProviderStateMixin {
  RiveAssets selectedBottomNav = bottomNavs.first;
  late AnimationController _animationController;
  late Animation animation;
  late Animation scaleAnimation;
  late SMIBool isSidebarClosed;
  bool isSideMenuClosed = false;
  @override
  void initState() {
    isSideMenuClosed = false;
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    )..addListener(() {
        setState(() {});
      });
    animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
          parent: _animationController, curve: Curves.fastOutSlowIn),
    );
    scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(
      CurvedAnimation(
          parent: _animationController, curve: Curves.fastOutSlowIn),
    );
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor2,
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Stack(
        children: [
          AnimatedPositioned(
            curve: Curves.fastOutSlowIn,
            duration: Duration(milliseconds: 200),
            width: 288,
            left: isSideMenuClosed ? -288 : 0,
            height: MediaQuery.of(context).size.height,
            child: SideMenu(),
          ),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(animation.value - 30 * animation.value * pi / 180),
            child: Transform.translate(
                offset: Offset(animation.value * 265, 0),
                child: Transform.scale(
                  scale: scaleAnimation.value,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                    child: HomeScreen(),
                  ),
                )),
          ),
          AnimatedPositioned(
            curve: Curves.fastOutSlowIn,
            top: 16,
            left: isSideMenuClosed ? 0 : 220,
            duration: Duration(milliseconds: 200),
            child: MenuBtn(
              riveOnInit: (artboard) {
                StateMachineController controller = RiveUtils.getRiveController(
                    artboard,
                    stateMachineName: "State Machine");
                isSidebarClosed = controller.findSMI('isOpen') as SMIBool;
                isSidebarClosed.value = true;
              },
              press: () {
                isSidebarClosed.value = !isSidebarClosed.value;
                if (isSideMenuClosed) {
                  _animationController.forward();
                } else {
                  _animationController.reverse();
                }

                setState(() {
                  isSideMenuClosed = isSidebarClosed.value;
                });
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Transform.translate(
        offset: Offset(0, (animation.value * 100)),
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            decoration: BoxDecoration(
              color: backgroundColor2.withOpacity(0.8),
              borderRadius: BorderRadius.all(Radius.circular(24)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...List.generate(
                  bottomNavs.length,
                  (index) => GestureDetector(
                    onTap: () {
                      bottomNavs[index].input!.change(true);
                      if (bottomNavs[index] != selectedBottomNav) {
                        setState(() {
                          selectedBottomNav = bottomNavs[index];
                        });
                      }
                      Future.delayed(Duration(seconds: 1), () {
                        bottomNavs[index].input!.change(false);
                      });
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedBar(
                          isActive: bottomNavs[index] == selectedBottomNav,
                        ),
                        SizedBox(
                          height: 36,
                          width: 36,
                          child: Opacity(
                            opacity: bottomNavs[index] == selectedBottomNav
                                ? 1
                                : 0.5,
                            child: RiveAnimation.asset(
                              bottomNavs.first.src,
                              artboard: bottomNavs[index].artboard,
                              onInit: (artboard) {
                                StateMachineController controller =
                                    RiveUtils.getRiveController(artboard,
                                        stateMachineName:
                                            bottomNavs[index].stateMachineName);
                                bottomNavs[index].input =
                                    controller.findSMI('active') as SMIBool;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
