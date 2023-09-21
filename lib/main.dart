import 'package:flutter/material.dart';
import 'package:todo/home_layout/home_layout.dart';
import 'package:todo/style/my_theme.dart';
import 'package:todo/tabs/settings_tab.dart';
import 'package:todo/tabs/tasks_tab.dart';
import '';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context)=> const HomeScreen(),
        TasksTab.routeName: (context)=> const TasksTab(),
        SettingsTab.routeName: (context)=> const SettingsTab(),
      },
      theme: MyThemeData.lightTheme,
      darkTheme: MyThemeData.darkTheme,
    );
  }
}

