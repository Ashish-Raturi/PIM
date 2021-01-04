import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pim/models/pim_user.dart';

class UserDbService {
  String uid;

  UserDbService({this.uid});

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //User Data
  // add & update
  Future addUserData(String mailId, String fullName, String password,
      String mobile, String location) async {
    await _firestore.collection(uid).doc('User Data').set({
      'Email Id': mailId,
      'Full Name': fullName,
      'Password': password,
      'Mobile': mobile,
      'Location': location
    });
  }

  // get user data steam
  Stream<PimUserData> get getUserData {
    return _firestore
        .collection(uid)
        .doc('User Data')
        .snapshots()
        .map(pimUserDataFormSnapshot);
  }

  // get pim User List Form Snapshot
  PimUserData pimUserDataFormSnapshot(DocumentSnapshot snapshot) {
    return PimUserData(
      email: snapshot.get('Email Id') ?? '',
      name: snapshot.get('Full Name') ?? '',
      mobile: snapshot.get('Mobile') ?? '',
      location: snapshot.get('Location') ?? '',
      password: snapshot.get('Password') ?? '',
    );
  }

  // Delete Data

}
