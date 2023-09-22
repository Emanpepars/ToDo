import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/firebase/firebase_functions.dart';
import 'package:todo/model/task_model.dart';
import 'package:todo/screens/edit_screen.dart';
import 'package:todo/style/my_theme.dart';

class TaskCard extends StatefulWidget {
  TaskModel task;
  TaskCard(this.task, {super.key});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.transparent),
      ),
      elevation: 12,
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: .4,
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              autoClose: true,
              onPressed: (context) {
                FireBaseFunctions.deleteTask(widget.task.id);
              },
              backgroundColor: const Color(0xFFFE4A49),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
            SlidableAction(
              autoClose: true,
              onPressed: (context) {
                Navigator.pushNamed(
                    context,
                    EditScreen.routeName,
                  arguments: TaskModel(
                    id: widget.task.id,
                      title: widget.task.title,
                      description: widget.task.description,
                      state: widget.task.state,
                      date: widget.task.date,
                  ),
                );
                },
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),
          ],
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, top: 25.0, bottom: 25, right: 25),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(5.0), // Adjust the radius as needed
                  color: widget.task.state
                      ? MyThemeData.greenColor
                      : MyThemeData.lightColor,
                ),
                width: 4,
                height: MediaQuery.of(context).size.height * .08,
                child: const VerticalDivider(),
              ),
              const SizedBox(
                width: 25,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.task.title,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: widget.task.state
                              ? MyThemeData.greenColor
                              : MyThemeData.lightColor,
                        ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.task.description,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              const Spacer(),
              widget.task.state
                  ? Text(
                      "Done!",
                      style:
                          Theme.of(context).textTheme.headlineLarge!.copyWith(
                                color: Colors.green,
                              ),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        setState(
                          () {
                            widget.task.state = true;
                            FireBaseFunctions.updateTask(
                                widget.task.id, widget.task);
                          },
                        );
                      },
                      child: const Icon(Icons.done),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
