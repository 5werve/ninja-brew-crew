import 'package:firebase_auth/firebase_auth.dart';
import 'package:ninja_brew_crew/models/appUser.dart';
import 'package:ninja_brew_crew/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  // underscore before var name means that it's private
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on Firebase's User obj
  AppUser? _appUserFromFirebaseUser(User? user) {
    return user != null ? AppUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<AppUser?> get user {
    return _auth
        .authStateChanges()
        // .map((User? user) => _appUserFromFirebaseUser(user)) // same as below
        .map(_appUserFromFirebaseUser);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _appUserFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInUserWithEmailandPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _appUserFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailandPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      // create a new document for the use with the uid
      await DatabaseService(uid: user!.uid)
          .updateUserData('0', 'new crew member', 100);

      return _appUserFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
