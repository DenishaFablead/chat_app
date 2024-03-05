
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/view/Chat_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  //instance of auth
  final FirebaseAuth _auth =FirebaseAuth.instance;
  
  //sign user out
  void signOut()
  {
      final authService =Provider.of<AuthService>(context ,listen: false);
      authService.signOut();

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text("Home page"),
      
      actions: [IconButton(onPressed:signOut , icon: Icon(Icons.logout))],
      ),
      body: _buildUserList(),
    );
  }
  //build a list of users except for the current logged in user
  Widget _buildUserList()
  {
      return StreamBuilder<QuerySnapshot>(
        
        stream: FirebaseFirestore.instance.collection('users').snapshots(), 
      
    builder: (context, snapshot) {
      if(snapshot.hasError)
      {
        return Text("error");
      }
      if(snapshot.connectionState == ConnectionState.waiting){
        return  Text("loading.");
      }
      return ListView(
        children: snapshot.data!.docs.map<Widget>(
        (doc) => _buildUserListItem(doc))
        .toList(),
      );
    }, 
  );
  }


  //build indidual user list items
Widget _buildUserListItem(DocumentSnapshot document)
{
  Map<String,dynamic> data =document.data()! as Map<String,dynamic>;
  if(_auth.currentUser!.email!=data['email'])
{
  return ListTile(
    title: Text(data['email']),
    onTap:() {
      //pass the clicked use's UID to the chat page
      Get.to(ChatPage(recevierUserEmail:data['email'] ,recevierUserID:data['uid'] ,));
    }, 
  );
}
else
{
  return Container();
}

}

// display all users except current user



}