import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/model/task_model.dart';

class FireBaseFunctions{
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
    return getTaskCollection().doc(id).update(task.toJson(),
    );
  }
  static Stream<QuerySnapshot<TaskModel>> getTasksFromFireStore(DateTime dateTime){
    var collection = getTaskCollection();
    return collection
        .where("date", isEqualTo: dateTime.millisecondsSinceEpoch)
        .snapshots();
  }
}
