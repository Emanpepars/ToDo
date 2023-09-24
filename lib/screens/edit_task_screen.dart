import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/task_model.dart';
import 'package:todo/provider/edit_task_provider.dart';
import 'package:todo/reusable/widget/cu_text_form_field.dart';

class EditTaskScreen extends StatelessWidget{
  const EditTaskScreen({Key? key}) : super(key: key);
  static const String routeName = "editTaskScreen";

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as TaskModel;
    var editProvider = Provider.of<EditTaskProvider>(context);
    editProvider.titleController = TextEditingController(text:args.title,);
    editProvider.noteController = TextEditingController(text:args.description,);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: editProvider.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      InkWell(
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          size: 20,
                          color: Colors.black,
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.account_circle_outlined,
                        size: 30,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Edit Task",
                    style: GoogleFonts.quicksand(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CuText(
                    "Title",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CuTextField(
                    title: args.title,
                    controller: editProvider.titleController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter Task title";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CuText(
                    "Note",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CuTextField(
                    title: args.description,
                    controller: editProvider.noteController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter Task Description";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CuText(
                    "Date",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CuTime(
                      editProvider.selected.toString().substring(0, 10),
                    FontAwesomeIcons.solidCalendarDays,
                    onTap: (){
                      editProvider.chooseDate(context);
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // Row(
                  //   children: [
                  //     Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         CuText(
                  //           "Start Time",
                  //           fontSize: 12,
                  //         ),
                  //         const SizedBox(
                  //           height: 10,
                  //         ),
                  //         CuTime(
                  //           "args.startDate.toString()",
                  //           FontAwesomeIcons.clock,
                  //           width: MediaQuery.of(context).size.width * .44,
                  //           height: 50,
                  //           onTap: editProvider.showStartTimePicker(context,args.startDate,),
                  //         ),
                  //       ],
                  //     ),
                  //     const SizedBox(
                  //       width: 16,
                  //     ),
                  //     Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         CuText(
                  //           "End Time",
                  //           fontSize: 12,
                  //         ),
                  //         const SizedBox(
                  //           height: 10,
                  //         ),
                  //         CuTime(
                  //          " args.endDate.toString()",
                  //           FontAwesomeIcons.clock,
                  //           width: MediaQuery.of(context).size.width * .44,
                  //           height: 50,
                  //           onTap: editProvider.showEndTimePicker(context, args.endDate,),
                  //         ),
                  //       ],
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(
                    height: 15,
                  ),
                  CuText(
                    "Remind",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CuDrop(
                    item: const [
                      "daily",
                      "weakly",
                      "monthly",
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CuText(
                    "Repeat",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CuDrop(
                    item: const [
                      "daily",
                      "weakly",
                      "monthly",
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CuText("Color"),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(3, (index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    editProvider.onCircleTap(index);
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: editProvider.avatarColors[index],
                                    radius: 14.0,
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: editProvider.selectedAvatar == index
                                          ? 20.0
                                          : 0.0, // Show checkmark if selected
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                          ),
                          onPressed: () {
                            editProvider.onSaveChangeTap(args.id, args.userId, context , args.startDate,args.endDate,);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                              "Save Changes",
                              style: GoogleFonts.quicksand(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
