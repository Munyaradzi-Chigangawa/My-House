import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_house/models/userModel.dart';

import 'home.dart';

class Profile extends StatelessWidget {
  const Profile({ Key? key, required this.user }) : super(key: key);
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    final TextEditingController _nameController = TextEditingController(text: user.name);
    return Scaffold(
        backgroundColor: Color(0xfff1efe5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 50,),
            ),
            SizedBox(height: 20,),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your Full Name...'
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              if (_nameController.text != ''){
                FirebaseFirestore.instance.collection('users').doc(user.uid).update({
                  'name': _nameController.text,
              }).then((value) {
                user.name = _nameController.text;
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(user: user) ));
              });
              }
            }, 
            child: Text('Update'))
          ],
        ),
      ),
    );
  }
}