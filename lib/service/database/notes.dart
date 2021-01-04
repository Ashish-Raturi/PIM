import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pim/models/note_data.dart';

class NoteDbService {
  String uid;

  NoteDbService({this.uid});

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Notes Data
  // add
  Future addNote(String title, String note, String colorIndex) async {
    return await _firestore
        .collection(uid)
        .doc('Note Data')
        .collection('Notes')
        .doc()
        .set({'Title': title, 'Note': note, 'Color Index': colorIndex});
  }

  // update
  Future updateNote(
      String title, String note, String docId, String colorIndex) async {
    return await _firestore
        .collection(uid)
        .doc('Note Data')
        .collection('Notes')
        .doc(docId)
        .set({'Title': title, 'Note': note, 'Color Index': colorIndex});
  }

  // get note data stream
  Stream<List<NotesData>> get getNoteData {
    return _firestore
        .collection(uid)
        .doc('Note Data')
        .collection('Notes')
        .snapshots()
        .map(notesListFormSnapshot);
  }

  // get note List Form Snapshot
  List<NotesData> notesListFormSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((doc) => NotesData(
            title: doc.get('Title'),
            note: doc.get('Note'),
            colorIndex: doc.get('Color Index'),
            docId: doc.id))
        .toList();
  }

  // delete
  Future deleteNote(String docId) async {
    return await _firestore
        .collection(uid)
        .doc('Note Data')
        .collection('Notes')
        .doc(docId)
        .delete();
  }
}
