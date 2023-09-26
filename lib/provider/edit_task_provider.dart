import 'package:flutter/material.dart';

class EditTaskProvider extends ChangeNotifier {
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();
  var selected = DateUtils.dateOnly(
    DateTime.now(),
  );
  int selectedAvatar = 0; // Index of the selected avatar

  final List<Color> avatarColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
  ];  // List of avatar colors

  late String initialTitleValue;

  var editFormKey = GlobalKey<FormState>();

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

  showStartTimePicker(context, startDate) {
    showTimePicker(
      context: context,
      initialTime: startDate,
    ).then((value) {
      startTime = value!;
      notifyListeners();
    });
  }

  showEndTimePicker(context, endDate) {
    showTimePicker(
      context: context,
      initialTime: endDate,
    ).then((value) {
      endTime = value!;
      notifyListeners();
    });
  }

  onCircleTap(index) {
    selectedAvatar = index; // Set the selected index
    notifyListeners();
  }
}
