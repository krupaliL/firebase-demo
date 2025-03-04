import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              Text(
                'Login with your Account',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 40),
              Form(
                key: controller.loginFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        // filled: true,
                        // fillColor: Colors.lightBlue.shade50,
                        hintText: 'Email',
                        hintStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.black38,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: controller.password,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.black38,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.login();
                        },
                        child: Text('Login'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
