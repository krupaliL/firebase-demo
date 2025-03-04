import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_demo/home/home_screen.dart';
import 'package:firebase_demo/user/user_model.dart';
import 'package:firebase_demo/user/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../auth/authentication_repository.dart';

class RegisterController extends GetxController {
  static RegisterController get instance => Get.find();

  /// Variables
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  /// SIGNUP
  void signup() async {
    try {
      // Form Validation
      if (!registerFormKey.currentState!.validate()) {
        // Remove Loader
        Get.snackbar('Error', 'User is not validate',
            snackPosition: SnackPosition.BOTTOM);
        return;
      }

      // Register user in the Firebase Authentication & Save user data in the Firebase
      final userCredential = await AuthenticationRepository.instance.registerWithEmailAndPassword(email: email.text.trim(), password: password.text.trim(),);

      // Save Authentication user data in the Firebase Firestore
      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        email: email.text.trim(),
      );

      final FirebaseFirestore _db = FirebaseFirestore.instance;
      await _db.collection('Users').doc(newUser.id).set(newUser.toJson());
      // final userRepository = Get.put(UserRepository());
      // await userRepository.saveUserRecord(newUser);

      Get.snackbar('Success', 'Registration Successful!',
          snackPosition: SnackPosition.BOTTOM);
      Get.to(() => HomeScreen());
    } catch (e) {
      log(e.toString(), name: 'Signup');
      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}