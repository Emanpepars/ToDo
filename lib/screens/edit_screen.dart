import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/firebase/firebase_functions.dart';
import 'package:todo/model/task_model.dart';
import 'package:todo/provider/themeProvider.dart';

class EditScreen extends StatefulWidget {
  static const String routeName = "edit";
  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var selected = DateUtils.dateOnly(
    DateTime.now(),
  );

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as TaskModel;
    var themeProvider = Provider.of<ThemeProvider>(context);
    titleController = TextEditingController(text:args.title,);
    descriptionController = TextEditingController(text:args.description,);
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: themeProvider.themeMode == ThemeMode.light
              ? const AssetImage("assets/light_bg.png")
              : const AssetImage("assets/dark_bg.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(27.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "To Do List",
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .8,
                    child: Card(
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      margin: EdgeInsets.all(20),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text(
                              "Edit Task",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: titleController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Enter Task title";
                                } else if (value.length < 10) {
                                  return "Please Enter at least 10 char";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.title,
                                  size: 25,
                                  color: Theme.of(context).primaryColor,
                                ),

                                hintText: args.title,
                                hintStyle:
                                    Theme.of(context).textTheme.titleSmall,

                                // labelStyle: Theme.of(context).textTheme.titleSmall,
                              ),
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: descriptionController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Enter Task Description";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.description,
                                  size: 25,
                                  color: Theme.of(context).primaryColor,
                                ),
                                hintText: args.description,
                                hintStyle:
                                    Theme.of(context).textTheme.titleSmall,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                "Select time",
                                style: Theme.of(context).textTheme.bodyMedium,
                                textAlign: TextAlign.start,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                chooseDate();
                              },
                              child: Text(
                                selected.toString().substring(0, 10),
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  TaskModel task = TaskModel(
                                    id: args.id,
                                    title: titleController.text,
                                    description: descriptionController.text,
                                    state: false,
                                    date: selected.millisecondsSinceEpoch,
                                    userId: args.userId,
                                  );
                                  FireBaseFunctions.updateTask(task.id, task)
                                      .then(
                                    (value) => Navigator.pop(context),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      25.0), // Adjust the radius as needed
                                ),
                              ),
                              child: const Text(
                                " Save Changes ",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
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
