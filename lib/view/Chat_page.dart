import 'package:chat_app/componets/chat_bubble.dart';
import 'package:chat_app/componets/my_text_field.dart';
import 'package:chat_app/services/auth/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.recevierUserEmail, required this.recevierUserID});
final String recevierUserEmail;
final String recevierUserID;
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController= TextEditingController();
  final ChatService _chatService =ChatService();
  final FirebaseAuth _firebaseAuth =FirebaseAuth.instance;
 
 void sendMessage() async{
  //on;y send message if there is something to send
  if(_messageController.text.isNotEmpty){
    await _chatService.sendMessage(widget.recevierUserID, _messageController.text);
    //clear the text controller after sending the mesage
    _messageController.clear();

  }
 }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.recevierUserEmail)),
    body: Column(
      children: [
        Expanded(child: _buildMessageList()),

        //User Input
        _buildMessageInput(),
        SizedBox(height: 25,)
      ],
    ),
    );
  }
  // build message list
  Widget _buildMessageList()
  {
     return StreamBuilder(
      stream: _chatService.getMessages(widget.recevierUserID, _firebaseAuth.currentUser!.uid), 
      builder: (context, snapshot) {
        if(snapshot.hasError)
        {
         return Text("error ${snapshot.error}");
        }
        if(snapshot.connectionState ==ConnectionState.waiting)
        {
          return const Text("loading");
        }
        return ListView(
          children: snapshot.data!.docs.map((documnet) => _buildMessageItem(documnet)).toList(),
        );
      },);
  }

  //build message item
     Widget _buildMessageItem(DocumentSnapshot document){
        Map<String ,dynamic> data= document.data() as Map<String,dynamic>;
        //align the message to the right if the sender is the current user , otherwise to the left
        var aligment =(data['senderId']==_firebaseAuth.currentUser!.uid)? Alignment.centerRight :Alignment.centerLeft;
     
      return Container(
        alignment: aligment,
        child: Column(
          crossAxisAlignment: (data['senderId']==_firebaseAuth.currentUser!.uid) ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          mainAxisAlignment: (data['senderId']==_firebaseAuth.currentUser!.uid) ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Text(data['senderEmail'], style: TextStyle(color: Colors.black)),
          SizedBox(height: 5,),
           ChatBubble(message: data['message'])
            
          ],
        ),
      );
     }
  //build message input
  Widget _buildMessageInput()
  {
    return Row(
      children: [
        Expanded(child: MyTextField(controller: 
        _messageController, hintText: "Enter message", obscureText: false)),
     IconButton(onPressed: () {
       
     }, icon: Icon(Icons.image,size: 40,))
        ,IconButton(onPressed: sendMessage, icon: Icon(Icons.arrow_upward,size: 40,))
      ],
    );
  }
}