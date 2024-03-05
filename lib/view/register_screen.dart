import 'package:chat_app/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../componets/my_button.dart';
import '../componets/my_text_field.dart';

class Register_Screen extends StatefulWidget {
  final void Function()? onTap;
  const Register_Screen({super.key, this.onTap});

  @override
  State<Register_Screen> createState() => _Register_ScreenState();
}

class _Register_ScreenState extends State<Register_Screen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passconfController = TextEditingController();
  void singUP() async {
    if (passconfController.text != passconfController.text) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Password do not match")));
   
   return;
    }
    final authService =Provider.of<AuthService>(context, listen: false);
    try {
      await authService.signUpWithEmailPassword(emailController.text, passconfController.text);
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
                Text("Let's create an account for you!"),
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
                  height: Get.height / 100,
                ),
                MyTextField(
                    controller: passconfController,
                    hintText: "Enter confirm password",
                    obscureText: true),
                SizedBox(
                  height: Get.height / 50,
                ),
                My_button(onTap: singUP, text: "Sign Up"),
                SizedBox(
                  height: Get.height / 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Already a member? ",
                      style: TextStyle(
                          fontSize: Get.width / 22, color: Colors.grey.shade600),
                    ),
                    GestureDetector(
                        onTap: widget.onTap,
                        child: Text("Login now",
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
