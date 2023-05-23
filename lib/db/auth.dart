import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veterna_poultry/utils/pages.dart';

import '../widgets/show_snackbar.dart';
import 'database_methods.dart';

//class ini buat ngumpulin fungsi dari firebase auth, dari login,register, sama logout.
// bakal dipanggil di beberapa layout yang butuh, nnti bakal ada ketambahan juga buat crud dari firestore

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      ShowSnackbar.snackBarNormal('Login Successfully');
      Get.offAllNamed(AppPages.HOME);
      // FirebaseFirestore.instance
      //     .collection('users')
      //     .doc(currentUser!.uid)
      //     .get()
      //     .then(
      //   (DocumentSnapshot documentSnapshot) {
      //     if (documentSnapshot.exists) {
      //       if (documentSnapshot.get('role') == "user") {
      //         ShowSnackbar.snackBarNormal('Login Successfully');
      //         Get.offAllNamed(AppPages.HOME);
      //       } else {
      //         ShowSnackbar.snackBarNormal('You aren\'t user');
      //         _firebaseAuth.signOut();
      //         Get.offAllNamed(AppPages.LOGIN);
      //       }
      //     }
      //   },
      // );
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      ShowSnackbar.snackBarError(e.message.toString());
    }
  }

  Future<void> createUserWithEmailAndPassword({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
    required String phone,
    required String address,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      Map<String, dynamic> userInfoMap = {
        "name": name,
        "phone": phone,
        "address": address,
        "img_path": null,
        "role": "user"
      };

      DatabaseMethod().addUserInfoToDB(currentUser!.uid, userInfoMap);
      ShowSnackbar.snackBarNormal('Congratulation Account Created');
      Get.offAllNamed(AppPages.HOME);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      ShowSnackbar.snackBarError(e.message.toString());
    }
  }

  Future<void> resetPassword({
    required BuildContext context,
    required String email,
  }) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      ShowSnackbar.snackBarSuccess('Sent Email Successfully');
      Get.offAllNamed(AppPages.LOGIN);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      ShowSnackbar.snackBarError(e.message.toString());
    }
  }

  Future<void> signOut({
    required BuildContext context,
  }) async {
    try {
      await _firebaseAuth.signOut();
      Get.offAllNamed(AppPages.LOGIN);
      ShowSnackbar.snackBarSuccess('Logout Succesfully');
    } on FirebaseAuthException catch (e) {
      ShowSnackbar.snackBarError(e.message.toString());
    }
  }
}
