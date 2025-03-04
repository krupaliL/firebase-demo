import 'dart:developer';

import 'package:firebase_demo/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../auth/authentication_repository.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  /// Variables
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  /// LOGIN
  void login() async {
    try {
      // Form Validation
      if (!loginFormKey.currentState!.validate()) {
        // Remove Loader
        Get.snackbar('Error', 'User is not validate',
            snackPosition: SnackPosition.BOTTOM);
        return;
      }

      // Register user in the Firebase Authentication & Save user data in the Firebase
      final userCredential = await AuthenticationRepository.instance.loginWithEmailAndPassword(email: email.text.trim(), password: password.text.trim(),);

      Get.snackbar('Success', 'Login Successfully!',
          snackPosition: SnackPosition.BOTTOM);
      Get.to(() => HomeScreen());
    } catch (e) {
      log(e.toString(), name: 'Login');
      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
