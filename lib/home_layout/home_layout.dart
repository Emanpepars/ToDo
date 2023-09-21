import 'package:flutter/material.dart';
import 'package:todo/style/my_theme.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:todo/tabs/settings_tab.dart';
import 'package:todo/tabs/tasks_tab.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = "login";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _bottomNavIndex= 0;
  List<Widget> tabs = const[TasksTab(),SettingsTab(),];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/light_bg.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          extendBody: true,
          body: tabs[_bottomNavIndex],
              floatingActionButton: FloatingActionButton(
                onPressed: () {  },
                child:const Icon(Icons.add),
                //params
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: AnimatedBottomNavigationBar(
                icons: const [Icons.menu, Icons.settings_outlined],
                activeIndex: _bottomNavIndex,
                gapLocation: GapLocation.center,
                notchSmoothness: NotchSmoothness.smoothEdge,
                onTap: (index) => setState(() => _bottomNavIndex = index), //other params
              ),
        ),
      ),
    );
  }
}
