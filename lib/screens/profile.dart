import 'package:flutter/material.dart';
import 'package:my_house/models/userModel.dart';

class Profile extends StatelessWidget {
  const Profile({ Key? key, required this.user }) : super(key: key);
  final UserModel user;
  @override
  Widget build(BuildContext context) {
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
            
          ],
        ),
      ),
    );
  }
}