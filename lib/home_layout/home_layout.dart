import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/firebase/firebase_functions.dart';
import 'package:todo/model/task_model.dart';
import 'package:todo/provider/home_provider.dart';
import 'package:todo/provider/themeProvider.dart';
import 'package:todo/reusable/widget/cu_text_form_field.dart';
import 'package:todo/reusable/widget/task_card.dart';
import 'package:todo/screens/add_task_screen.dart';
import 'package:shimmer/shimmer.dart';


class HomeScreen extends StatefulWidget {

  static const String routeName = "home screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool light = true;
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var homeProvider = Provider.of<HomeProvider>(context);
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
                        setState(() {
                          light = !light;
                        });
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
                      )),
                  const Spacer(),
                  const Icon(
                    Icons.account_circle_outlined,
                    size: 35,
                    color: Colors.black,
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
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          "+ Add Task",
                          style: GoogleFonts.quicksand(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              light ?
              DatePicker(
                DateTime.now(),
                initialSelectedDate: DateTime.now(),
                selectionColor: Theme.of(context).primaryColor,
                unSelectedTextColor: Colors.black,
                height: MediaQuery.of(context).size.height * 0.13,
                width: MediaQuery.of(context).size.height * 0.09,
                onDateChange: (date) {
                  // New date selected
                  homeProvider.onDateChange(date);
                },
              )
                  :DatePicker(
                DateTime.now(),
                initialSelectedDate: DateTime.now(),
                selectionColor: Theme.of(context).primaryColor,
                unSelectedTextColor: Colors.white,
                height: MediaQuery.of(context).size.height * 0.13,
                width: MediaQuery.of(context).size.height * 0.09,
                onDateChange: (date) {
                  // New date selected
                  homeProvider.onDateChange(date);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: StreamBuilder(
                  stream: FireBaseFunctions.getTasksFromFireStore(homeProvider.dateTime),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          enabled: true,
                          child: SingleChildScrollView(
                            physics: const NeverScrollableScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 100.0, // Adjust the height as needed
                                  color: Colors.white,
                                ),
                                const SizedBox(height: 16.0),
                                Container(
                                  width: double.infinity,
                                  height: 20.0, // Adjust the height as needed
                                  color: Colors.white,
                                ),
                                const SizedBox(height: 16.0),
                                Container(
                                  width: double.infinity,
                                  height: 40.0, // Adjust the height as needed
                                  color: Colors.white,
                                ),
                                const SizedBox(height: 16.0),
                                Container(
                                  width: double.infinity,
                                  height: 20.0, // Adjust the height as needed
                                  color: Colors.white,
                                ),
                                const SizedBox(height: 16.0),
                                Container(
                                  width: 200.0, // Adjust the width as needed
                                  height: 20.0, // Adjust the height as needed
                                  color: Colors.white,
                                ),
                                const SizedBox(height: 16.0),
                                Container(
                                  width: double.infinity,
                                  height: 80.0, // Adjust the height as needed
                                  color: Colors.white,
                                ),
                                const SizedBox(height: 16.0),
                                Container(
                                  width: 200.0, // Adjust the width as needed
                                  height: 20.0, // Adjust the height as needed
                                  color: Colors.white,
                                ),
                                const SizedBox(height: 16.0),
                              ],
                            ),
                          ));
                    }

                    List<TaskModel> tasks = snapshot.data?.docs
                        .map((task) => task.data())
                        .toList() ??
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
                            CuText(
                              "Oops! You don't",
                            ),
                            CuText("have any to do list today"),
                          ],
                        ),
                      );
                    }

                    // Sort the tasks by start date.
                    tasks.sort((a, b) => a.startDate.compareTo(b.startDate));

                    homeProvider.maxStepValue = tasks.length -
                        1; // Update the maximum step value based on tasks
                    return Stepper(
                      controlsBuilder: homeProvider.controlBuilders,
                      type: StepperType.vertical,
                      // Set to vertical
                      currentStep: homeProvider.currentStep,
                      // Set the current step index here
                      steps: tasks.map((task) {
                        // Create a Step widget for each task.
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
