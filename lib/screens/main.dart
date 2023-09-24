import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/firebase_options.dart';
import 'package:todo/home_layout/home_layout.dart';
import 'package:todo/provider/add_task_provider.dart';
import 'package:todo/provider/edit_task_provider.dart';
import 'package:todo/provider/home_provider.dart';
import 'package:todo/provider/init_user_provider.dart';
import 'package:todo/provider/themeProvider.dart';
import 'package:todo/screens/add_task_screen.dart';
import 'package:todo/screens/edit_task_screen.dart';
import 'package:todo/screens/login_screen.dart';
import 'package:todo/screens/register_screen.dart';
import 'package:todo/screens/settings_tab.dart';
import 'package:todo/style/my_theme.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //Firebase FireStore.instance.disableNetwork();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => InitUserProvider()),
        ChangeNotifierProvider<HomeProvider>(
          create: (context) {
            // Create and initialize the HomeProvider with the steps data.
            HomeProvider homeProvider = HomeProvider();
            List<Step> steps = [];
            homeProvider.steps = steps;
            homeProvider.maxStepValue = steps.length - 1;
            return homeProvider;
          },
        ),
        ChangeNotifierProvider<AddTaskProvider>(
          create: (context) {
            AddTaskProvider addTaskProvider =AddTaskProvider();
            var now = DateTime.now();
            addTaskProvider.endTime = TimeOfDay(hour: now.hour, minute: now.minute);
            addTaskProvider.startTime = TimeOfDay(hour: now.hour, minute: now.minute);

            return AddTaskProvider();
          },
        ),
        ChangeNotifierProvider(create: (context) => EditTaskProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var initUserProvider = Provider.of<InitUserProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute:
      initUserProvider.firebaseUser!= null?
      HomeScreen.routeName :RegisterScreen.routeName ,
      routes: {
        SettingsTab.routeName: (context) => const SettingsTab(),
        LoginScreen.routeName: (context) => LoginScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        HomeScreen.routeName: (context) =>  HomeScreen(),
        AddTaskScreen.routeName: (context) => const AddTaskScreen(),
        EditTaskScreen.routeName: (context)=> const EditTaskScreen(),
      },
      theme: MyThemeData.lightTheme,
      darkTheme: MyThemeData.darkTheme,
      themeMode: themeProvider.themeMode,
    );
  }
}
