import 'package:firebase_demo/login/login_screen.dart';
import 'package:firebase_demo/signup/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.to(LoginScreen());
              },
              child: Text('Login'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.to(RegisterScreen());
              },
              child: Text('SignUp'),
            ),
          ],
        ),
      ),
    );
  }
}
