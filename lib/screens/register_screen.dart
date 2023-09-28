import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo/firebase/firebase_functions.dart';
import 'package:todo/provider/init_user_provider.dart';
import 'package:todo/reusable/widget/cu_text_form_field.dart';
import 'package:todo/screens/login_screen.dart';
import 'package:todo/style/const.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static const String routeName = "register";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool eyeClick = false;

  @override
  Widget build(BuildContext context) {
    var initUserProvider = Provider.of<InitUserProvider>(context);
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Theme.of(context).brightness == Brightness.light
              ? const AssetImage("assets/register_background.png")
              : const AssetImage("assets/register_backgroundBk.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .04,
                ),
                Row(
                  children: [
                    InkWell(
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        Navigator.pop(context,);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Register",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).brightness == Brightness.light
                            ? Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(color: white)
                            : Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(color: black),
                      ),
                    ),
                    const Icon(
                      Icons.visibility_off_outlined,
                      color: Colors.transparent,
                    ),
                    const Icon(
                      Icons.visibility_off_outlined,
                      color: Colors.transparent,
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .25),
                Column(
                  children: [
                    CuRegisterTextField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {}
                        return null;
                      },
                      controller: emailController,
                      labelText: "Email",
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CuRegisterTextField(
                      obscureText: !eyeClick,
                      validator: (value) {
                        if (value == null || value.isEmpty) {}
                        return null;
                      },
                      controller: passwordController,
                      labelText: "Password",
                      textInputAction: TextInputAction.done,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            eyeClick = !eyeClick;
                          });
                        },
                        icon: eyeClick ? const Icon(FontAwesomeIcons.eye ,size:20,) : const Icon(FontAwesomeIcons.eyeSlash,size: 20,),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          textStyle: MaterialStateProperty.all<TextStyle?>(
                            GoogleFonts.quicksand(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            FireBaseFunctions.createUserWithEmailAndPassword(
                              emailController.text,
                              passwordController.text,
                              () {
                                initUserProvider.initUser();
                                Navigator.pushReplacementNamed(
                                    context, LoginScreen.routeName);
                              },
                            );
                          }
                        },
                        child: const Row(
                          children: [
                            Text("Register"),
                            Spacer(),
                            Icon(Icons.arrow_forward),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "already have account?",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, LoginScreen.routeName);
                          },
                          child: Text(
                            "Sign in",
                            style: GoogleFonts.poppins(
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? lightColor
                                  : darkColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
