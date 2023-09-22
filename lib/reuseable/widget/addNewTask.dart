import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/firebase/firebase_functions.dart';
import 'package:todo/model/task_model.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  var selected = DateUtils.dateOnly(
    DateTime.now(),
  );
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20, top: 10),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize:
              MainAxisSize.min, // Ensure that the column takes minimal space
          children: [
            Divider(
              thickness: 4,
              color: Theme.of(context).primaryColor,
              endIndent: MediaQuery.of(context).size.width % 100,
              indent: MediaQuery.of(context).size.width % 100,
            ),
            const SizedBox(
              height: 25,
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
                label: Text(
                  "Title",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                // labelStyle: Theme.of(context).textTheme.titleSmall,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
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
                label: Text(
                  "Description",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_month_outlined,
                    size: 25,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(
                    width: 10,
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
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  TaskModel task = TaskModel(
                    userId: FirebaseAuth.instance.currentUser!.uid,
                    title: titleController.text,
                    description: descriptionController.text,
                    state: false,
                    date: selected.millisecondsSinceEpoch,
                  );
                  FireBaseFunctions.addTask(task).then(
                    (value) => Navigator.pop(context),
                  );
                }
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  " Add ",
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
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
