import 'package:firebase_demo/auth/authentication_repository.dart';
import 'package:firebase_demo/update/update_name_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../user/user_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final homeController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Obx(() {
                final temp = homeController.user.value;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("First Name: ${temp.firstName}", style: TextStyle(fontSize: 18)),
                    Text("Last Name: ${temp.lastName}", style: TextStyle(fontSize: 18)),
                    Text("Email: ${temp.email}", style: TextStyle(fontSize: 18)),
                  ],
                );
              }),
            ),
            SizedBox(height: 30),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => UpdateNameScreen());
                },
                // onPressed: () async {
                //   var result = await Get.to(() => UpdateNameScreen());
                //   if (result != null) {
                //     if (result)  {
                //       homeController.fetchUserRecord();
                //     }
                //   }
                // },
                child: Text('Update Name'),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  AuthenticationRepository.instance.logout();
                },
                child: Text('Logout'),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  AuthenticationRepository.instance.deleteAccount();
                },
                child: Text('Delete Account'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
