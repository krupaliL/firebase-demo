import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_demo/auth/authentication_repository.dart';
import 'package:firebase_demo/user/user_model.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final userId = AuthenticationRepository.instance.authUser!.uid;

  Future<void> saveUserRecord(UserModel user) async {
    try {
      _db.collection('Users').doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      log(e.toString(), name: 'saveUserRecordFirebaseAuthException');
      throw e.toString();
    } catch (e) {
      log(e.toString(), name: 'saveUserRecord');
      throw e.toString();
    }
  }

  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db.collection('Users').doc(userId).get();
      if(documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } on FirebaseException catch (e) {
      log(e.toString(), name: 'fetchUserDetailsFirebaseAuthException');
      throw e.toString();
    } catch (e) {
      log(e.toString(), name: 'fetchUserDetails');
      throw e.toString();
    }
  }

  /// Function to remove user data from Firestore.
  Future<void> removeUserRecord(String userId) async {
    try {
      await _db.collection("Users").doc(userId).delete();
    } on FirebaseException catch (e) {
      throw e.toString();
    } on FormatException catch (e) {
      throw e.toString();
    } catch (e) {
      log(e.toString(), name: 'removeUserRecord');
      throw 'Something went wrong. Please try again';
    }
  }
}