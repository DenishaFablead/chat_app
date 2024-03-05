  import 'package:chat_app/view/login_screen.dart';
import 'package:chat_app/view/register_screen.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  
  //initially show the login screen
  bool showLoginPage = true;
  
  void toggolePages()
  {
    setState(() {
      showLoginPage =!showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
   if(showLoginPage){
    return  LoginScreen(onTap: toggolePages);
   }
  
   else
   {
    return Register_Screen(onTap: toggolePages);
   }
  }
}