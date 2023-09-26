import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/firebase/firebase_functions.dart';
import 'package:todo/model/task_model.dart';
import 'package:todo/provider/home_provider.dart';
import 'package:todo/provider/init_user_provider.dart';
import 'package:todo/provider/themeProvider.dart';
import 'package:todo/reusable/widget/cu_container_shimmer.dart';
import 'package:todo/reusable/widget/task_card.dart';
import 'package:todo/screens/add_task_screen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:todo/screens/login_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "home screen";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var homeProvider = Provider.of<HomeProvider>(context);
    var initUser = Provider.of<InitUserProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      themeProvider.changeTheme(
                          themeProvider.themeMode == ThemeMode.light
                              ? ThemeMode.dark
                              : ThemeMode.light);
                    },
                    child: themeProvider.themeMode == ThemeMode.light
                        ? const ImageIcon(
                            AssetImage("assets/moon_icon.png"),
                            size: 20,
                          )
                        : const ImageIcon(
                            AssetImage(
                              "assets/sun_icon.png",
                            ),
                            size: 25,
                            color: Colors.white,
                          ),
                  ),
                  const Spacer(),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2<MenuItem>( // Specify the type for DropdownButton2
                      customButton: const Icon(
                        Icons.account_circle_outlined,
                        size: 35,
                      ),
                      items: [
                        DropdownMenuItem<MenuItem>(
                          value: MenuItems.logout,
                          child: MenuItems.buildItem(MenuItems.logout),
                        ),
                      ],
                      onChanged: (value) {
                        MenuItems.onChanged(context, value! , (){
                          initUser.signOut();
                          Navigator.pushNamed(context,LoginScreen.routeName);
                        });
                      },
                      dropdownStyleData: DropdownStyleData(
                        width: 140,
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color:
                          Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,
                        ),
                        offset: const Offset(0, 8),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        padding: EdgeInsets.only(left: 16, right: 16),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat.yMMMMd().format(
                          DateTime.now(),
                        ),
                        style: GoogleFonts.quicksand(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Today",
                        style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 45,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, AddTaskScreen.routeName);
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Text(
                          "+ Add Task",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                child: themeProvider.themeMode == ThemeMode.light
                    ? DatePicker(
                        DateTime.now(),
                        initialSelectedDate: DateTime.now(),
                        selectionColor: Theme.of(context).primaryColor,
                        unSelectedTextColor: Colors.black,
                        height: MediaQuery.of(context).size.height * 0.13,
                        width: MediaQuery.of(context).size.height * 0.09,
                        onDateChange: (date) {
                          homeProvider.onDateChange(date);
                        },
                      )
                    : SizedBox(
                        child: DatePicker(
                          DateTime.now(),
                          initialSelectedDate: DateTime.now(),
                          selectionColor: Theme.of(context).primaryColor,
                          unSelectedTextColor: Colors.white,
                          height: MediaQuery.of(context).size.height * 0.13,
                          width: MediaQuery.of(context).size.height * 0.09,
                          onDateChange: (date) {
                            homeProvider.onDateChange(date);
                          },
                        ),
                      ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: StreamBuilder(
                  stream: FireBaseFunctions.getTasksFromFireStore(
                      homeProvider.dateTime),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Shimmer.fromColors(
                        baseColor:
                            Theme.of(context).brightness == Brightness.light
                                ? Colors.grey.shade300
                                : Colors.grey.shade900,
                        highlightColor:
                            Theme.of(context).brightness == Brightness.light
                                ? Colors.grey.shade100
                                : Colors.grey.shade800,
                        enabled: true,
                        child: const SingleChildScrollView(
                          physics: NeverScrollableScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              CuContainerShimmer(
                                width: double.infinity,
                                height: 100.0,
                              ),
                              SizedBox(height: 16.0),
                              CuContainerShimmer(
                                width: double.infinity,
                                height: 20.0,
                              ),
                              SizedBox(height: 16.0),
                              CuContainerShimmer(
                                width: double.infinity,
                                height: 40.0,
                              ),
                              SizedBox(height: 16.0),
                              CuContainerShimmer(
                                width: double.infinity,
                                height: 20.0,
                              ),
                              SizedBox(height: 16.0),
                              CuContainerShimmer(
                                width: 200,
                                height: 20.0,
                              ),
                              SizedBox(height: 16.0),
                              CuContainerShimmer(
                                width: double.infinity,
                                height: 80.0,
                              ),
                              SizedBox(height: 16.0),
                              CuContainerShimmer(
                                width: 200,
                                height: 20.0,
                              ),
                              SizedBox(height: 16.0),
                            ],
                          ),
                        ),
                      );
                    }
                    List<TaskModel> tasks = snapshot.data?.docs.map((task) => task.data()).toList() ??
                        [];
                    if (tasks.isEmpty) {
                      return Center(
                        child: Column(
                          children: [
                            themeProvider.themeMode == ThemeMode.light
                                ? Image.asset(
                                    "assets/empty_task.png",
                                  )
                                : Image.asset(
                                    "assets/empty_task_dk.png",
                                  ),
                            Text(
                              "Oops! You don't",
                              style: Theme.of(context).textTheme.headlineSmall,

                            ),
                            Text(
                                "have any to do list today",
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ],
                        ),
                      );
                    }
                    tasks.sort((a, b) => a.startDate.compareTo(b.startDate));
                    homeProvider.maxStepValue = tasks.length - 1;
                    return Stepper(
                      controlsBuilder: homeProvider.controlBuilders,
                      type: StepperType.vertical,
                      currentStep: homeProvider.currentStep,
                      steps: tasks.map((task) {
                        final formattedTime = DateFormat('h:mm a').format(
                          DateTime(2023, 1, 1, task.startDate ~/ 60,
                              task.startDate % 60),
                        );
                        return Step(
                          title: Text(formattedTime),
                          content: TaskCard(task),
                          isActive: task.state,
                          state: task.state
                              ? StepState.complete
                              : StepState.disabled,
                        );
                      }).toList(),
                      onStepTapped: homeProvider.onStepTapped,
                      onStepContinue: homeProvider.continueStep,
                      onStepCancel: homeProvider.cancelStep,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}


class MenuItem {
  const MenuItem({
    required this.text,
    required this.icon,
  });

  final String text;
  final IconData icon;
}

class MenuItems {
  static const logout = MenuItem(text: 'Logout', icon: Icons.logout);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Colors.white, size: 22),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            item.text,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  static void onChanged(BuildContext context, MenuItem item ,Function toDo) {
    switch (item) {
      case MenuItems.logout:
        toDo();
        print('hi');
        break;
    }
  }
}