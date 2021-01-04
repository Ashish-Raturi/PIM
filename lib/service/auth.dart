import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pim/models/pim_user.dart';
import 'package:pim/service/database/user_data.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  //user form firebase user
  PimUser _userFormFirebaseUser(User user) {
    // var userData = user.providerData;

    return user != null
        ? PimUser(
            uid: user.uid,
          )
        : null;
  }

  Stream<PimUser> get user {
    return _auth.authStateChanges().map(_userFormFirebaseUser);
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      User user = result.user;
      return _userFormFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with google
  // Future<User> signInWithGoogle() async {
  //   final dynamic googleSigninAccount = await _googleSignIn.signIn();
  //   if (googleSigninAccount == null) {
  //     print('User enter back button');
  //     return null;
  //   } else {
  //     final gsa = await googleSigninAccount.authentication;
  //     final credential = GoogleAuthProvider.credential(
  //         accessToken: gsa.accessToken, idToken: gsa.idToken);
  //     User user = (await _auth.signInWithCredential(credential)).user;
  //     // await UserDbService(uid: user.uid).addUserData(
  //     //     user.email, user.displayName, 'Password', 'Mobile No', 'Address');
  //     return user;
  //   }
  // }

  // create account with email and password
  Future createAccountWithEmailAndPasword(
      String email, String password, String fullName) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      User user = result.user;
      // adding user data in database with uid
      await UserDbService(uid: user.uid)
          .addUserData(email, fullName, password, '', '');

      return _userFormFirebaseUser(user);
    } catch (e) {
      print("\n***sign up error****\n");
      print(e.toString());
      return null;
    }
  }
}
