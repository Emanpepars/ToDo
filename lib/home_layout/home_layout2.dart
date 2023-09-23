import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/firebase/firebase_functions.dart';
import 'package:todo/model/task_model.dart';
import 'package:todo/provider/themeProvider.dart';
import 'package:todo/reusable/widget/task_card.dart';
import 'package:todo/screens/add_task_screen.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);
  static const String routeName = "taskScreen";

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  DateTime dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
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
                      themeProvider.changeTheme(themeProvider.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light );
                    },
                    child: themeProvider.themeMode == ThemeMode.light
                        ? const ImageIcon(
                            AssetImage("assets/moon_icon.png"),
                            size: 20,
                          )
                        : const ImageIcon(
                      AssetImage("assets/sun_icon.png",),
                      size: 25,
                      color: Colors.white,
                    )
                  ),
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
              DatePicker(
                DateTime.now(),
                initialSelectedDate: DateTime.now(),
                selectionColor: Colors.blue,
                selectedTextColor: Colors.white,
                height: MediaQuery.of(context).size.height * .13,
                width: MediaQuery.of(context).size.height * .09,
                onDateChange: (date) {
                  // New date selected
                  setState(
                    () {
                      dateTime = date;
                    },
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              StreamBuilder(
                stream: FireBaseFunctions.getTasksFromFireStore(dateTime),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  List<TaskModel> tasks =
                      snapshot.data?.docs.map((task) => task.data()).toList() ??
                          [];
                  if (tasks.isEmpty) {
                    return const Center(child: Text("No tasks"));
                  }
                  return Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return TaskCard(tasks[index]);
                      },
                      itemCount: tasks.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                        height: 4,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
