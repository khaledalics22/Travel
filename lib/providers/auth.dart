import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';

class Auther with ChangeNotifier {
  static final _authInstance = FirebaseAuth.instance;
  static final _usersCollectionRef =
      FirebaseFirestore.instance.collection('users');

  Stream<dynamic> checkLogin() => _authInstance.authStateChanges();

  Future<UserCredential> login(String email, String pass) async {
    return  _authInstance.signInWithEmailAndPassword(
      email: email,
      password: pass,
    );
    //     .then(onComplete, onError: (value) {
    //   onComplete(null);
    // });
  }

  Future<UserCredential> createUserWithEmailAndPass(
      String email, String pass) async {
    // print('khalidddddddddddddddd');
    // print(_authInstance);
    return  _authInstance.createUserWithEmailAndPassword(
      email:email,
      password: pass,
    );
    //     .then((result) {
    //   print('khalidddddddddddddddd');
    //   user.id = result.user.uid;
    //   return _addUser(user, onComplete);
    // }, onError: (value) {
    //   print('errrorrrrrrrrr');
    //   onComplete(null);
    // });
  }

  Future<void> addUser(CustomUser user) async {
    // String uid = _usersCollectionRef.doc().id;
    // user.id = uid;
    return  _usersCollectionRef.doc(user.id).set(user.toJson);
    // .then(onComplete)
    // .catchError((_) => onComplete(null));
  }

  Future<void> logOut() async {
    return  _authInstance.signOut();
  }

  Future<void> updateUser(CustomUser user) {
    return _usersCollectionRef.doc(_authInstance.currentUser.uid).update(user.toJson);
    // .then((value) => onComplete)
    // .catchError(onComplete(null));
  }

  Future<DocumentSnapshot> getUser() async {
    return  _usersCollectionRef.doc(_authInstance.currentUser.uid)?.get();
    // .get()
    // .then(onComplete).catchError(onComplete(null));
  }
}
