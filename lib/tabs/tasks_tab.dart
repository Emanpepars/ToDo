import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/reuseable/widget/task_card.dart';
import 'package:todo/style/my_theme.dart';

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
        const SizedBox(height: 10,),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5,),
            child: ListView.builder(
              itemBuilder: (context, index) => const TaskCard(),
              itemCount: 8,
            ),
          ),
        ),

      ],
    );
  }
}
