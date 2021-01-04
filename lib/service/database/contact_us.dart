import 'package:cloud_firestore/cloud_firestore.dart';

class ContactUsDbService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // add & update
  Future addUserData(String name, String email, String message) async {
    return await _firestore
        .collection("Contact Us")
        .add({'Name': name, 'Email': email, 'Message': message});
  }
}
