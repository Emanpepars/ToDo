import 'package:flutter/material.dart';
import 'package:todo/firebase/firebase_functions.dart';
import 'package:todo/model/task_model.dart';

class EditTaskProvider extends ChangeNotifier{
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


  void chooseDate(context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 360 * 22)),
    );
    if (selectedDate != null) {
        selected = DateUtils.dateOnly(selectedDate);
        notifyListeners();
    }
    notifyListeners();
  }

   void showStartTimePicker(context,startTime) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
        startTime = value!;
        Navigator.pop(context);
    });
    notifyListeners();
   }
   void showEndTimePicker(context,endTime) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
        endTime = value!;
        Navigator.pop(context);
    });
    notifyListeners();
   }

  onCircleTap(index){
    selectedAvatar =
        index; // Set the selected index
    notifyListeners();
  }
  onSaveChangeTap(argsId , argsUserId , context,startTime , endTime){
    if (formKey.currentState!.validate()) {
      TaskModel task = TaskModel(
        id: argsId,
        title: titleController.text,
        description: noteController.text,
        state: false,
        date: selected.millisecondsSinceEpoch,
        endDate: endTime.hour * 60 + endTime.minute,     // Convert TimeOfDay to int
        startDate: startTime.hour * 60 + startTime.minute,
        userId: argsUserId,
      );
      FireBaseFunctions.updateTask(task.id, task)
          .then(
            (value) => Navigator.pop(context),
      );
      notifyListeners();
    }
    notifyListeners();
  }

}