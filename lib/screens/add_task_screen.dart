import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/firebase/firebase_functions.dart';
import 'package:todo/model/task_model.dart';
import 'package:todo/reuseable/widget/cu_text_form_field.dart';

class AddTaskScreen extends StatefulWidget {
  AddTaskScreen({Key? key}) : super(key: key);
  static const String routeName = "addTaskScreen";

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  var selected = DateUtils.dateOnly(
    DateTime.now(),
  );
  int selectedAvatar = 0; // Index of the selected avatar

  // List of avatar colors
  final List<Color> avatarColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
  ];
  var formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();

  TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      InkWell(
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          size: 20,
                          color: Colors.black,
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.account_circle_outlined,
                        size: 30,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Add Task",
                    style: GoogleFonts.quicksand(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CuText(
                    "Title",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CuTextField(
                    title: "Enter title here",
                    controller: titleController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter Task Description";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CuText(
                    "Note",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CuTextField(
                    title: "Enter note here",
                    controller: noteController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter Task Description";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CuText(
                    "Date",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CuTime(
                    selected.toString().substring(0, 10),
                    FontAwesomeIcons.solidCalendarDays,
                     onTap:  (){
                        chooseDate();
                      },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CuText(
                            "Start Time",
                            fontSize: 12,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CuTime(
                            "23.56 Am",
                            FontAwesomeIcons.clock,
                            width: MediaQuery.of(context).size.width * .44,
                            height: 50,
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CuText(
                            "End Time",
                            fontSize: 12,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CuTime(
                            "hi",
                            FontAwesomeIcons.clock,
                            width: MediaQuery.of(context).size.width * .44,
                            height: 50,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CuText(
                    "Remind",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CuDrop(
                    item: const [
                      "daily",
                      "weakly",
                      "monthly",
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CuText(
                    "Repeat",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CuDrop(
                    item: const [
                      "daily",
                      "weakly",
                      "monthly",
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
                          CuText("Color"),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(3, (index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedAvatar =
                                          index; // Set the selected index
                                    },
                                    );
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: avatarColors[index],
                                    radius: 14.0,
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: selectedAvatar == index
                                          ? 20.0
                                          : 0.0, // Show checkmark if selected
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                          ),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              TaskModel task = TaskModel(
                                userId: FirebaseAuth.instance.currentUser!.uid,
                                title: titleController.text,
                                description: noteController.text,
                                state: false,
                                date: selected.millisecondsSinceEpoch,
                              );
                              FireBaseFunctions.addTask(task).then(
                                    (value) => Navigator.pop(context),
                              );
                            }
                            },
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                              "Create Task",
                              style: GoogleFonts.quicksand(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void chooseDate() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 360 * 22)),
    );
    if (selectedDate != null) {
      setState(() {
        selected = DateUtils.dateOnly(selectedDate);
      });
    }
  }
}
