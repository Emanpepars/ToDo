import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider/themeProvider.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({Key? key}) : super(key: key);
  static const String routeName = "settings";

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(27.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .09,
            ),
            Text(
              "Settings",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              "Language",
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: 20, color: Colors.black),
            ),
            const SizedBox(
              height: 25,
            ),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.blue,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.all(5),
              child: DropdownButton(
                  iconDisabledColor: Colors.blue,
                  iconEnabledColor: Colors.blue,
                  iconSize: 30,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                underline: const SizedBox(),
                isExpanded: true,
                value: themeProvider.themeMode,
                onChanged: (ThemeMode? newTheme) {
                  if (newTheme != null) {
                    themeProvider.changeTheme(newTheme);
                  }
                },
                items: <DropdownMenuItem<ThemeMode>>[
                  DropdownMenuItem<ThemeMode>(
                    value: ThemeMode.light,
                    child: Text(
                      "English",
                      style: themeProvider.themeMode == ThemeMode.light ?Theme.of(context).textTheme.bodyLarge:Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  DropdownMenuItem<ThemeMode>(
                    value: ThemeMode.dark,
                    child: Text(
                      "arabic",
                      style: themeProvider.themeMode == ThemeMode.dark ?Theme.of(context).textTheme.bodyLarge:Theme.of(context).textTheme.bodyMedium,

                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              "Theming",
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: 20, color: Colors.black),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.blue,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.all(5),
              child: DropdownButton(
                iconDisabledColor: Colors.blue,
                iconEnabledColor: Colors.blue,
                iconSize: 30,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                underline: const SizedBox(),
                isExpanded: true,
                value: themeProvider.themeMode,
                onChanged: (ThemeMode? newTheme) {
                  if (newTheme != null) {
                    themeProvider.changeTheme(newTheme);
                  }
                },
                items: <DropdownMenuItem<ThemeMode>>[
                  DropdownMenuItem<ThemeMode>(
                    value: ThemeMode.light,
                    child: Text(
                      "Light",
                      style: themeProvider.themeMode == ThemeMode.light ?Theme.of(context).textTheme.bodyLarge:Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  DropdownMenuItem<ThemeMode>(
                    value: ThemeMode.dark,
                    child: Text(
                      "Dark",
                      style: themeProvider.themeMode == ThemeMode.dark ?Theme.of(context).textTheme.bodyLarge:Theme.of(context).textTheme.bodyMedium,

                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
