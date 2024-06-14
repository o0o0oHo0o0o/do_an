
import 'package:weather/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/my_user.dart';
import '../provider/loading_provider.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  MyUser? _userFromFirebaseUser(User? user){
    return user != null ? MyUser(uid: user.uid) : null;
  }
  //stream
  Stream<MyUser?> get user{
    return _auth.authStateChanges().map((User? user){
      if (user != null) {
        return _userFromFirebaseUser(user);
      } else {
        return null;
      }
    });
  }

  //sign in with email & password
  Future signInWithEmailAndPassword(String email,String password) async{
    try{
      email = email.trim();
      password = password.trim();
      UserCredential res = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = res.user;
      return _userFromFirebaseUser(user);
    } catch(e){
      print('Sign in error: ${e.toString()}');
      return null;
    }
  }
  bool isEmailVerified() {
    User? user = _auth.currentUser;
    return user!.emailVerified;
  }
  Future<void> sendEmailVerification() async {
    User? user = _auth.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    }
  }
  // register with email & password
  Future registerWithEmailAndPassword(String email, String password) async{
    try {
      email = email.trim();
      password = password.trim();
      UserCredential res = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = res.user;
      await user?.sendEmailVerification();
      return _userFromFirebaseUser(user);
    } catch(e){
      print('Register error: ${e.toString()}');
      return null;
    }
  }

  //sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print('Sign out error: ${e.toString()}');
    }
  }

}