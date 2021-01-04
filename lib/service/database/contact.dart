import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pim/models/contact_data.dart';

class ContactDbService {
  String uid;

  ContactDbService({this.uid});

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Contact Data
  // add & update
  Future addContact(String name, String pn) async {
    await _firestore
        .collection(uid)
        .doc('Contact Data')
        .collection('Contacts')
        .add({'Name': name, 'Phone Number': pn});
  }

  //update
  Future updateContact(String name, String pn, String docId) async {
    await _firestore
        .collection(uid)
        .doc('Contact Data')
        .collection('Contacts')
        .doc(docId)
        .set({'Name': name, 'Phone Number': pn});
  }

  // get contact data stream
  Stream<List<ContactData>> get getContactData {
    return _firestore
        .collection(uid)
        .doc('Contact Data')
        .collection('Contacts')
        .snapshots()
        .map(contactListFormSnapshot);
  }

  // get contact List Form Snapshot
  List<ContactData> contactListFormSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((doc) => ContactData(
            name: doc.get('Name'), pn: doc.get('Phone Number'), docId: doc.id))
        .toList();
  }

  //delete
  Future deleteContact(String docId) async {
    return await _firestore
        .collection(uid)
        .doc('Contact Data')
        .collection('Contacts')
        .doc(docId)
        .delete();
  }
}
