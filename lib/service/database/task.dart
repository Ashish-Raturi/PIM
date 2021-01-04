import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:pim/models/task_data.dart';

class TaskDbService {
  String uid;

  TaskDbService({this.uid});

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // Task Data
  // add
  Future addTask(String task, String date, bool isDone) async {
    await _firestore
        .collection(uid)
        .doc('Task Data')
        .collection('Tasks')
        .doc()
        .set({'Task': task, 'Date': date, 'isDone': isDone});
  }

  //update
  Future updateTask(String task, String date, bool isDone, String docId) async {
    await _firestore
        .collection(uid)
        .doc('Task Data')
        .collection('Tasks')
        .doc(docId)
        .set({'Task': task, 'Date': date, 'isDone': isDone});
  }

  // get contact data stream
  Stream<List<TaskData>> get getTaskData {
    return _firestore
        .collection(uid)
        .doc('Task Data')
        .collection('Tasks')
        .snapshots()
        .map(tasksListFormSnapshot);
  }

  // get task List Form Snapshot
  List<TaskData> tasksListFormSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((doc) => TaskData(
            task: doc.get('Task'),
            date: doc.get('Date'),
            isDone: doc.get('isDone'),
            docId: doc.id))
        .toList();
  }

  //delete
  Future deleteTask(String docId) async {
    return await _firestore
        .collection(uid)
        .doc('Task Data')
        .collection('Tasks')
        .doc(docId)
        .delete();
  }
}
