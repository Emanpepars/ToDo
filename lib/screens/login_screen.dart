import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo/firebase/firebase_functions.dart';
import 'package:todo/home_layout/home_layout.dart';
import 'package:todo/provider/init_user_provider.dart';
import 'package:todo/reusable/widget/cu_text_form_field.dart';
import 'package:todo/screens/register_screen.dart';
import 'package:todo/style/const.dart';


class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);
  static const String routeName = "login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                Text(
                  "Login",
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
                SizedBox(height: MediaQuery.of(context).size.height * .25),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome back!",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CuRegisterTextField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      controller: emailController,
                      labelText: "Email",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CuRegisterTextField(
                      obscureText: !eyeClick,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.done,
                      controller: passwordController,
                      labelText: "Password",
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            eyeClick = !eyeClick;
                          });
                        },
                        icon: eyeClick ? const Icon(FontAwesomeIcons.eye ,size:20,) : const Icon(FontAwesomeIcons.eyeSlash,size: 20,),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forget password?",
                       style: GoogleFonts.poppins(
                          color:Theme.of(context).brightness == Brightness.light
                              ? lightColor
                              : darkColor,
                         fontWeight: FontWeight.w500,
                         fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),

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
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            try {
                              await FireBaseFunctions
                                  .signInWithEmailAndPassword(
                                      emailController.text,
                                      passwordController.text, () {
                                initUserProvider.initUser();
                                Navigator.pushReplacementNamed(
                                    context, HomeScreen.routeName);
                              });
                            } catch (e) {
                              // Handle login errors here
                              print("Error: $e");
                              // Show a SnackBar with the error message
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Error: $e"),
                                ),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Validation error."),
                              ),
                            );
                          }
                        },
                        child: const Row(
                          children: [
                            Text("Login"),
                            Spacer(),
                            Icon(Icons.arrow_forward),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),

                    Row(
                      children:[
                        Text(
                          "Or",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.w500,fontSize: 16,),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, RegisterScreen.routeName);
                          },
                          child: Text(
                            "Create My Account ?",
                            style: GoogleFonts.poppins(
                              color:Theme.of(context).brightness == Brightness.light
                                  ? lightColor
                                  : darkColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ]
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
