import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/firebase/firebase_functions.dart';
import 'package:todo/provider/init_user_provider.dart';
import 'package:todo/screens/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  static const String routeName = "register";
  @override
  Widget build(BuildContext context) {
    var initUserProvider = Provider.of<InitUserProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: formKey,
          child: Column(
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
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()){
                    FireBaseFunctions.createUserWithEmailAndPassword(
                      emailController.text,
                      passwordController.text,
                        (){
                          initUserProvider.initUser();
                          Navigator.pushNamed(context, LoginScreen.routeName);
                        },
                    );
                  }

                },
                child: const Text(
                  "Register",
                ),
              ),
              Row(
                children: [
                  const Text("already have account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, LoginScreen.routeName);
                    },
                    child: const Text(
                      "Sign in",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
