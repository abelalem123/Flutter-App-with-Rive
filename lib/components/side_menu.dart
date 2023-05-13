import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:rive_animation/models/rive_assets.dart';
import 'package:rive_animation/utils/rive_utils.dart';

import 'info_card.dart';
import 'side_menu_tile.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  RiveAssets selectedMenu = sideMenus.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 288,
        height: double.infinity,
        color: Color(0xFF17203A),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InfoCard(
                name: "Abel Alem",
                profession: "Developer",
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                child: Text(
                  'Browse'.toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white70),
                ),
              ),
              ...sideMenus.map((menu) => SideMenuTile(
                  menu: menu,
                  press: () {
                    menu.input?.change(true);
                    Future.delayed(Duration(seconds: 1), () {
                      menu.input?.change(false);
                    });
                    setState(() {
                      selectedMenu = menu;
                    });
                  },
                  riveOnInit: (artboard) {
                    StateMachineController controller =
                        RiveUtils.getRiveController(artboard,
                            stateMachineName: menu.stateMachineName);
                    menu.input = controller.findSMI('active') as SMIBool;
                  },
                  isActive: selectedMenu == menu)),
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                child: Text(
                  'History'.toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white70),
                ),
              ),
              ...sideMenu2.map((menu) => SideMenuTile(
                  menu: menu,
                  press: () {
                    menu.input?.change(true);
                    Future.delayed(Duration(seconds: 1), () {
                      menu.input?.change(false);
                    });
                    setState(() {
                      selectedMenu = menu;
                    });
                  },
                  riveOnInit: (artboard) {
                    StateMachineController controller =
                        RiveUtils.getRiveController(artboard,
                            stateMachineName: menu.stateMachineName);
                    menu.input = controller.findSMI('active') as SMIBool;
                  },
                  isActive: selectedMenu == menu)),
            ],
          ),
        ),
      ),
    );
  }
}
