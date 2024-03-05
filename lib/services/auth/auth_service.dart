import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier{
  //instance of auth

  final FirebaseAuth _firebaseAuth =FirebaseAuth.instance;

//instant of the firestore

  final FirebaseFirestore _firestore =FirebaseFirestore.instance;
  Future<UserCredential> signInWithEmailandPassword 
  (String email, String password) async
  {
      try{
        UserCredential userCredential =await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password
        );
        
       //add a new document for the user in users collection if it dosen't aleready exists
      
_firestore.collection('users').doc(userCredential.user!.uid).set(
  {
    "uid":userCredential.user!.uid,
    "email":email
  },SetOptions(merge: true)
);
      
      
       return  userCredential;
      } 
      
      //catch any error
      on FirebaseAuthException catch (e)
      {
        throw  Exception(e.code);
      }

  }

//creat a new user 
Future<UserCredential>signUpWithEmailPassword(String email,String password)async
{
    try {
      UserCredential userCredential= 
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
         password: password);

//after creating user , crete a new for user collection

_firestore.collection('users').doc(userCredential.user!.uid).set(
  {
    "uid":userCredential.user!.uid,
    "email":email
  }
);
         return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
}

//sign user out
Future<void>signOut()async{
    return await FirebaseAuth.instance.signOut();
}
}

