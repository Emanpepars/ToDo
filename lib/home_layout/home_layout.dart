import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider/themeProvider.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:todo/reuseable/widget/addNewTask.dart';
import 'package:todo/screens/tabs/settings_tab.dart';
import 'package:todo/screens/tabs/tasks_tab.dart';
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
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: themeProvider.themeMode == ThemeMode.light ? const AssetImage("assets/light_bg.png"):const AssetImage("assets/dark_bg.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          extendBody: true,
          body: tabs[_bottomNavIndex],
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding:  EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: const AddNewTask(),
                        );
                      }
                  );
                },
                shape: const StadiumBorder(
                    side: BorderSide(
                      color: Colors.white,
                      width: 4,
                    ),),
                child:const Icon(Icons.add),
                //params
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: AnimatedBottomNavigationBar(
                icons: const [Icons.backup_table_sharp, Icons.settings_outlined],
                activeIndex: _bottomNavIndex,
                gapLocation: GapLocation.center,
                notchSmoothness: NotchSmoothness.defaultEdge,
                onTap: (index) => setState(() => _bottomNavIndex = index), //other params
              ),
        ),
      ),
    );
  }
}
