import 'package:flutter/material.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({Key? key}) : super(key: key);
  static const String routeName = "settings";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(27.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*.09,),
            Text("Settings",style: Theme.of(context).textTheme.headlineLarge,),
            const SizedBox(height: 25,),
            Text("Language",style: Theme.of(context).textTheme.bodyLarge,),
            const SizedBox(height: 25,),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                ),
              ),
              padding: const EdgeInsets.all(15),
              child: Text(
                "English",style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            const SizedBox(height: 25,),
            Text("Theming",style: Theme.of(context).textTheme.bodyLarge,),
            const SizedBox(height: 25,),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                ),
              ),
              padding: const EdgeInsets.all(15),
              child: Text(
                "Light",style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
