import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/model/task_model.dart';
import 'package:todo/model/user_model.dart';

class FireBaseFunctions{

  //task
  static CollectionReference<TaskModel> getTaskCollection() {
   return FirebaseFirestore.instance
        .collection('Tasks')
        .withConverter(
        fromFirestore: (snapshot,_)=> TaskModel.fromJson(snapshot.data()!),
        toFirestore: (task, options) => task.toJson(),
    );
  }
  static Future<void> addTask(TaskModel task){
    var collection = getTaskCollection();
    var docRef = collection.doc();
    task.id = docRef.id;
    return docRef.set(task);
  }
  static deleteTask(String id){
    return getTaskCollection().doc(id).delete();
  }
  static updateTask(String id,TaskModel task){
    return getTaskCollection().doc(id).update(task.toJson(),);
  }
  static Stream<QuerySnapshot<TaskModel>> getTasksFromFireStore(DateTime dateTime){
    var collection = getTaskCollection();
    return collection.where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where("date", isEqualTo: dateTime.millisecondsSinceEpoch)
        .snapshots();
  }

  //user base
  static CollectionReference<UserModel> getUserCollection() {
    return FirebaseFirestore.instance
        .collection('Users')
        .withConverter(
      fromFirestore: (snapshot,_)=> UserModel.fromJson(snapshot.data()!),
      toFirestore: (user, options) => user.toJson(),
    );
  }


  static Future<void> addUser(UserModel user){
    var collection = getUserCollection();
    var docRef = collection.doc(user.id);
    return docRef.set(user);
  }

  //user Auth
  static createUserWithEmailAndPassword(String email , String password,Function afterCreated,) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserModel userModel = UserModel(id: credential.user!.uid , email: email ,);
      addUser(userModel).then((value) => afterCreated(),);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
  static signInWithEmailAndPassword(String email , String password, Function afterLogged,) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      afterLogged();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  static Future<UserModel?> readUser(String id) async {
    DocumentSnapshot<UserModel> userSnap = await getUserCollection().doc(id).get();
    return userSnap.data();
  }

}
