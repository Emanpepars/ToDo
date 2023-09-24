import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:todo/firebase/firebase_functions.dart';
import 'package:todo/model/task_model.dart';
import 'package:todo/screens/edit_task_screen.dart';
import 'package:todo/style/const.dart';

class TaskCard extends StatefulWidget {
  TaskModel task;
  TaskCard(this.task, {super.key});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    final formattedStartTime = DateFormat('h:mm a').format(
      DateTime(
          2023, 1, 1, widget.task.startDate ~/ 60, widget.task.startDate % 60),
    );
    final formattedEndTime = DateFormat('h:mm a').format(
      DateTime(
          2023, 1, 1, widget.task.startDate ~/ 60, widget.task.startDate % 60),
    );
    return Card(
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.transparent),
      ),
      elevation: 12,
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: .5,
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
                  EditTaskScreen.routeName,
                  arguments: TaskModel(
                    endDate: widget.task.endDate,
                    startDate: widget.task.startDate,
                    userId: widget.task.userId,
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
                  color:
                      widget.task.state ? Theme.of(context).primaryColor : Colors.black,
                ),
                width: 4,
                height: MediaQuery.of(context).size.height * .09,
                child: const VerticalDivider(),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.task.title,
                      style:  widget.task.state ? Theme.of(context).textTheme.bodyLarge :Theme.of(context).textTheme.bodyLarge!.copyWith(color: black),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const Icon(
                          FontAwesomeIcons.clock,
                          size: 10,
                          color: black,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          formattedStartTime,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          formattedEndTime,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.task.description,
                      style:Theme.of(context).textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
              // const Spacer(),
              SizedBox(
                width: 5,
              ),
              widget.task.state
                  ? Text(
                      "Done!",
                      style:
                          Theme.of(context).textTheme.headlineLarge!.copyWith(
                                color: Colors.blue,
                              ),
                    )
                  : ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                      ),
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
