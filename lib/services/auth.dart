import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:moneymangement/module/user.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;

  // create obj base on Firebase User
  UserData _userFormFirebaseUser(FirebaseUser user) {
    return user != null ? UserData(currentUserId: user.uid) : null;
  }

  // auth change user stream
  Stream<UserData> get user {
    return _auth.onAuthStateChanged.map(_userFormFirebaseUser);
  }

  //sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFormFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//sign in email/pass
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFormFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // get uid
  Future<String> getCurrentUID() async {
    return (await _auth.currentUser()).uid;
  }

  //get user
  Future getCurrentUser() async {
    return await _auth.currentUser();
  }

//register
//  Future registerWithEmailAndPassword(String email, String password) async {
//    try {
//      AuthResult result = await _auth.createUserWithEmailAndPassword(
//          email: email, password: password);
//      FirebaseUser user = result.user;
//
//      //create user info with uid
//      return _userFormFirebaseUser(user);
//    } catch (e) {
//      print(e.toString());
//      return null;
//    }
//  }

  //register new
  Future<String> registerWithEmailAndPassword(
      BuildContext context,
      String email,
      String password,
      String name,
      String money,
      String phone) async {
    try {
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      FirebaseUser signedInUser = authResult.user;
      if (signedInUser != null) {
        _firestore.collection('users').document(signedInUser.uid).setData({
          'email': email,
          'name': name,
          'money': money,
          'phone': phone,
        });
        Provider.of<UserData>(context).currentUserId = signedInUser.uid;
        Navigator.pop(context);
      }
    } catch (e) {
      return e.code;
    }
    return '';
  }

  //register phone
//  Future<void> verifyPhone(phoneNo) async {
//    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
//      //To Do
//    };
//
//    final PhoneVerificationFailed verificationFailed =
//        (AuthException authException) {
//      print('${authException.message}');
//    };
//
//    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
//       this.verificationId = verId;
//    };
//
//    final PhoneCodeAutoRetrievalTimeout autoTimeout(String verId){
//      this.verificationId = verId;
//    };
//
//    await FirebaseAuth.instance.verifyPhoneNumber(phoneNumber: phoneNo,
//        timeout: const Duration(seconds: 5),
//        verificationCompleted: verified,
//        verificationFailed: verificationFailed,
//        codeSent: smsSent,
//        codeAutoRetrievalTimeout: autoTimeout);
//  }

//sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
