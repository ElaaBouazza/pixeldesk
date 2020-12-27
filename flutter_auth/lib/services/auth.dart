import 'package:flutter_auth/models/user.dart';
import 'package:flutter_auth/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  Usern _userFromFirebaseUser(User user) {
    return user != null ? Usern(uid:user.uid) : null;
  }

  // auth change user stream
  Stream<Usern> get user {
    return _auth.authStateChanges()
      //.map((FirebaseUser user) => _userFromFirebaseUser(user));
      .map(_userFromFirebaseUser);
  }



  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = (await _auth.signInWithEmailAndPassword(email: email, password: password)) as AuthResult;
      
      User user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    } 
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = (await _auth.createUserWithEmailAndPassword(email: email, password: password)) as AuthResult;
      
      User user = result.user;
      // create a new document for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData('0','new user', 100);
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    } 
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

}

class AuthResult {
  User get user => null;
}