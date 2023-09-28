import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{

  ThemeMode themeMode = ThemeMode.light;

  void changeTheme(mode){
    themeMode = mode;
    notifyListeners();
  }
}