import 'dart:developer';

import 'package:firebase_demo/auth/authentication_repository.dart';
import 'package:firebase_demo/user/user_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final authRepo = AuthenticationRepository.instance;
  GlobalKey<FormState> updateNameFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  Future<void> initializeNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
    try {
      // Update user's first & last name in the Firebase Firestore
      Map<String, dynamic> updateFirstName = {'firstName': firstName.text.trim()};
      await authRepo.updateSingleField(updateFirstName);
      Map<String, dynamic> updateLastName = {'lastName': lastName.text.trim()};
      await authRepo.updateSingleField(updateLastName);

      userController.fetchUserRecord();
      Get.back();
      // Get.back(result: true);
      // Get.off(HomeScreen());
      Get.snackbar('Success', 'Your name updated!',
          snackPosition: SnackPosition.BOTTOM);

    } catch (e) {
      log(e.toString(), name: 'updateUserName');
      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}