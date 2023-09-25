import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/model/task_model.dart';
import 'package:todo/screens/updateForm.dart';

class EditTaskScreen extends StatefulWidget {
  const EditTaskScreen(this.taskId, {super.key});
  final String taskId;
  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Tasks").doc(widget.taskId).snapshots(),
        builder: (context , snapshot){
          if(!snapshot.hasData){
            return const CircularProgressIndicator();
          }
          var output = snapshot.data!.data();
          TaskModel task = TaskModel(
              id: output!["id"],
              title: output["title"],
              description: output["description"],
              state: output["state"],
              date: output["date"],
              endDate: output["endDate"],
              startDate:output["startDate"],
              userId: output["userId"],
          );

          return UpdateForm(taskModel: task);
        },

      ),
    );
  }
}