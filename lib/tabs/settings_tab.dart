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
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 25,
            ),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) => Container(
                          color: Colors.red,
                        ));
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(),
                ),
                padding: const EdgeInsets.all(15),
                child: Text(
                  "English",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              "Theming",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 25,
            ),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) =>  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        InkWell(
                          onTap:(){
                            themeProvider.changeTheme(ThemeMode.light);
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Light",
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: themeProvider.themeMode == ThemeMode.light ? Colors.green: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap:(){
                            themeProvider.changeTheme(ThemeMode.dark);
                            Navigator.pop(context);

                          },
                          child: Text(
                            "Dark",
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: themeProvider.themeMode == ThemeMode.dark ? Colors.green: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(),
                ),
                padding: const EdgeInsets.all(15),
                child: Text(
                  themeProvider.themeMode == ThemeMode.light ?"Light" : "Dark",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
