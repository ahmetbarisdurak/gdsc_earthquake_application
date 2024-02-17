import 'package:google_solution_challenge/screens/explore/explore.dart';
import 'package:google_solution_challenge/screens/home/earthquaker/home_page.dart';
import 'package:google_solution_challenge/screens/home/maps/map_custom.dart';
import 'package:google_solution_challenge/screens/profile/sos_rev.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../controller/controller_sos.dart';

class NavBarSOS extends StatefulWidget {
  const NavBarSOS({super.key});
  @override
  State<NavBarSOS> createState() => _NavBarSOSState();
}

class _NavBarSOSState extends State<NavBarSOS> {
  final controller = Get.put(NavBarControllerSos());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavBarControllerSos>(builder: (context) {
      return Scaffold(
        body: IndexedStack(
          index: controller.tabIndex,
          children: const [SosRev(), MapUIcustom(), EarthquakerPage(), ExploreScreen()], // Camera eklenebilir
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: GNav(
              selectedIndex: controller.tabIndex,
              onTabChange: controller.changeTabIndex,
              backgroundColor: Colors.transparent,
              color: Colors.black,
              activeColor: const Color(0xffe97d47),
              tabBackgroundColor: const Color.fromARGB(43, 233, 125, 71),
              gap: 10.0,
              padding: const EdgeInsets.all(16.0),
              tabs: const [
                GButton(
                  icon: Icons.alarm,
                  text: "SOS",
                ),
                GButton(
                  icon: Icons.map,
                  text: "Maps",
                ),
                GButton(
                  icon: Icons.home,
                  text: "Home",
                ),
                GButton(
                  icon: Icons.camera_alt ,
                  text: "Camera",
                ),
                GButton(
                  icon: Icons.info,
                  text: "Information",
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}