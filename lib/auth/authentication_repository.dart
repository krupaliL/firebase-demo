import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/user/user_model.dart';
import 'package:firebase_demo/welcome_screen.dart';
import 'package:get/get.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Get Authenticated User Data
  User? get authUser => _auth.currentUser!;

  /// [EmailAuthentication] - LOGIN
  Future<UserCredential> loginWithEmailAndPassword({required String email, required String password}) async {
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    }on FirebaseAuthException catch (e) {
      log(e.toString(), name: 'createUserFirebaseAuthException');
      throw e.code == 'email-already-in-use' ? 'Account already registered. Please log in or use a different email.': e.toString();
    } catch (e) {
      log(e.toString(), name: 'createUserFirebaseAuthException');
      throw e.toString();
    }
  }

  /// [EmailAuthentication] - REGISTER
  Future<UserCredential> registerWithEmailAndPassword({required String email, required String password}) async {
    try {
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    }on FirebaseAuthException catch (e) {
      log(e.toString(), name: 'createUserFirebaseAuthException');
      throw e.code == 'email-already-in-use' ? 'Account already registered. Please log in or use a different email.': e.toString();
    } catch (e) {
      log(e.toString(), name: 'createUserFirebaseAuthException');
      throw e.toString();
    }
  }

  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db.collection('Users').doc(_auth.currentUser?.uid).get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } on FirebaseException catch (e) {
      throw e.toString();
    } catch (e) {
      log(e.toString(), name: 'fetchUserDetails');
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db.collection('Users').doc(_auth.currentUser?.uid).update(json);
    } on FirebaseException catch (e) {
      throw e.toString();
    } catch (e) {
      log(e.toString(), name: 'updateSingleField');
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      Get.snackbar('Logout', 'Logout!!!',
          snackPosition: SnackPosition.BOTTOM);
      Get.offAll(() => const WelcomeScreen());
    } on FirebaseAuthException catch (e) {
      log(e.toString(), name: 'logoutFirebaseAuthException');
      throw e.toString();
    } catch (e) {
      log(e.toString(), name: 'logoutError');
      throw e.toString();
    }
  }

  Future<void> deleteAccount() async {
    try {
      await FirebaseFirestore.instance.collection("Users").doc(_auth.currentUser!.uid).delete();
      await _auth.currentUser?.delete();
      Get.snackbar('SignOut', 'Your account deleted permanently!!!',
          snackPosition: SnackPosition.BOTTOM);
      Get.offAll(() => const WelcomeScreen());
    } on FirebaseAuthException catch (e) {
      log(e.toString(), name: 'FirebaseAuthException');
      throw e.toString();
    } catch (e) {
      log(e.toString(), name: 'deleteAccount');
      throw 'Something went wrong. Please try again';
    }
  }
}