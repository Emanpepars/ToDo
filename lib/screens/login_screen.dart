import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/firebase/firebase_functions.dart';
import 'package:todo/home_layout/home_layout.dart';
import 'package:todo/provider/init_user_provider.dart';
import 'package:todo/screens/registerscreen.dart';
import 'package:todo/screens/tabs/settings_tab.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  static const String routeName = "login";
  @override
  Widget build(BuildContext context) {
    var initUserProvider = Provider.of<InitUserProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Welcome back!"),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "please enter email";
                  }
                },
                controller: emailController,
                decoration: const InputDecoration(
                  label: Text("Email"),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "please enter email";
                  }
                },
                controller: passwordController,
                decoration: const InputDecoration(
                  label: Text("Password"),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Forget password?",
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    try {
                      await FireBaseFunctions.signInWithEmailAndPassword(
                        emailController.text,
                        passwordController.text,
                          (){
                            initUserProvider.initUser();
                            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                          }
                      );
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
                child: const Text("Login"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RegisterScreen.routeName);
                },
                child: const Text(
                  "Or Create My Account",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
