import 'package:chat_app/services/auth/login_or_register.dart';
import 'package:chat_app/view/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class auth_Gate extends StatelessWidget {
  const auth_Gate({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
     builder: (context, snapshot) {
       
       if(snapshot.hasData)
       {
        return const HomePage();
       }
       else
       {
        return const LoginOrRegister();
       }
     },
      ),
    );
  }
}