import 'dart:ffi';

import 'package:chat_app/componets/my_button.dart';
import 'package:chat_app/componets/my_text_field.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/view/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  final void Function()? onTap;
  LoginScreen({super.key, required this.onTap});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  void singIN() async{
//get auth service
    final authService = Provider.of<AuthService>(context, listen: false);
  
  try {
    await authService.signInWithEmailandPassword(emailController.text, passwordController.text);
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
                    child: Padding(
            padding: const EdgeInsets.all(19.0),
            child: Column(
              children: [
                SizedBox(
                  height: Get.height / 6,
                ),
                Icon(
                  Icons.message,
                  size: 100,
                ),
                Text("Welcome back youre been missed!"),
                SizedBox(
                  height: Get.height / 20,
                ),
                MyTextField(
                    controller: emailController,
                    hintText: "Enter email",
                    obscureText: false),
                SizedBox(
                  height: Get.height / 100,
                ),
                MyTextField(
                    controller: passwordController,
                    hintText: "Enter Password",
                    obscureText: true),
                SizedBox(
                  height: Get.height / 50,
                ),
                My_button(onTap: singIN, text: "Login"),
                SizedBox(
                  height: Get.height / 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Not a member? ",
                      style: TextStyle(
                          fontSize: Get.width / 22, color: Colors.grey.shade600),
                    ),
                    GestureDetector(
                        onTap: widget.onTap,
                        child: Text("Register now",
                            style: TextStyle(color: Colors.black)))
                  ],
                )
              ],
            ),
                    ),
                  ),
          )),
    );
  }
}
