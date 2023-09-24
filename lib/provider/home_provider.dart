import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier{
  // Create a Stepper widget to order the tasks by timer.
  List<Step> steps = [];

  DateTime dateTime = DateTime.now();

  int currentStep = 0;

  int maxStepValue = 0; // Maximum step value

  continueStep() {
      currentStep = currentStep + 1; //currentStep+=1;
    notifyListeners();
  }

  cancelStep() {
    if (currentStep > 0) {
        currentStep = currentStep - 1; //currentStep-=1;
        notifyListeners();
    }

  }

  onStepTapped(int value) {
      currentStep = value;
      notifyListeners();
  }

  Widget controlBuilders(context, details) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: currentStep < maxStepValue ? continueStep : null,
            child: const Text('Next'),
          ),
          const SizedBox(width: 10),
          OutlinedButton(
            onPressed: details.onStepCancel,
            child: const Text('Back'),
          ),
        ],
      ),
    );
  }

  onDateChange(date){
    dateTime = date;
    steps = [];
    currentStep = 0;
    maxStepValue = 0;
    notifyListeners();
  }
}
