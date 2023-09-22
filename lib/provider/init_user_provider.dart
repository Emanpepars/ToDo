import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/firebase/firebase_functions.dart';
import 'package:todo/model/UserModel.dart';

class InitUserProvider extends ChangeNotifier{
  UserModel? userModel;
  User? firebaseUser;
  InitUserProvider(){
    firebaseUser= FirebaseAuth.instance.currentUser;
    if(firebaseUser!=null){
      initUser();
    }
  }
  void initUser() async{
    firebaseUser= FirebaseAuth.instance.currentUser;
    userModel = await FireBaseFunctions.readUser(firebaseUser!.uid);
    notifyListeners();
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
    notifyListeners();
  }

}
