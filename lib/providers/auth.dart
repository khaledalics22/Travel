import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'user.dart';

class Auther with ChangeNotifier {
  CustomUser _user;

  CustomUser get user => _user;

  void setUser(var user) {
    _user = CustomUser.fromJson(user);
    // notifyListeners();
  }

  static final _authInstance = FirebaseAuth.instance;
  static final _usersCollectionRef =
      FirebaseFirestore.instance.collection('users');
  

  static final _usersStorageRef = FirebaseStorage.instance.ref();
  



  Stream<dynamic> checkLogin() => _authInstance.authStateChanges();

  Future<UserCredential> login(String email, String pass) async {
    return _authInstance.signInWithEmailAndPassword(
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
    return _authInstance.createUserWithEmailAndPassword(
      email: email,
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
    _user = user;
    notifyListeners();
    return _usersCollectionRef.doc(user.id).set(user.toJson);
    // .then(onComplete)
    // .catchError((_) => onComplete(null));
  }

  Future<void> logOut() async {
    await _authInstance.signOut();
    _user = null;
    notifyListeners();
  }

  Future<void> updateUser(CustomUser user) async {
    await _usersCollectionRef
        .doc(_authInstance.currentUser.uid)
        .update(user.toJson);
    this._user = user;
    notifyListeners();
    // .then((value) => onComplete)
    // .catchError(onComplete(null));
  }

  Future<DocumentSnapshot> getUser() async {
    return _usersCollectionRef.doc(_authInstance.currentUser.uid)?.get();
    // .get()
    // .then(onComplete).catchError(onComplete(null));
  }

  Future<String> uploadProfileImage(File imgFile) async {
    final ref = _usersStorageRef
        .child('users')
        .child('/${_authInstance.currentUser.uid}')
        .child('/profile.jpg');

    final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': imgFile.path});
    final task = ref.putData((await imgFile.readAsBytes()), metadata);
    return (await Future.value(task)).ref.getDownloadURL();
  }
}
