import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:todo/firebase/firebase_functions.dart';
import 'package:todo/model/task_model.dart';
import 'package:todo/reuseable/widget/task_card.dart';

class TasksTab extends StatefulWidget {
  const TasksTab({Key? key}) : super(key: key);
  static const String routeName = "task";

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  DateTime dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(27.0),
          child: Text(
            "To Do List",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        DatePicker(
          DateTime.now(),
          initialSelectedDate: DateTime.now(),
          selectionColor: Colors.white,
          selectedTextColor: Colors.blue,
          height: MediaQuery.of(context).size.height * .13,
          onDateChange: (date) {
            // New date selected
            setState(() {
              dateTime = date;
            });
          },
        ),
        const SizedBox(
          height: 10,
        ),
        StreamBuilder(
            stream: FireBaseFunctions.getTasksFromFireStore(dateTime),
            builder:
                (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              List<TaskModel> tasks = snapshot.data?.docs.map((task) => task.data()).toList() ?? [];
              if(tasks.isEmpty){
                return const Center(child: Text("No tasks"));
              }
               return Expanded(
                 child: Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: ListView.builder(
                     itemBuilder: (context, index) {
                       return TaskCard(tasks[index]);
                     },
                     itemCount: tasks.length,
                   ),
                 ),
               );
            },
        ),
      ],
    );
  }
}
