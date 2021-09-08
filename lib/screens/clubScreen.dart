import 'dart:js';

import 'package:flutter/material.dart';
import 'package:my_house/models/club.dart';
import 'package:my_house/models/userModel.dart';

class ClubScreen extends StatefulWidget {
  const ClubScreen({ Key? key, required this.user, required this.club }) : super(key: key);
  final UserModel user;
  final Club club;


  @override
  _ClubScreenState createState() => _ClubScreenState();
}

class _ClubScreenState extends State<ClubScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff1efe5),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40)
          ),
          child: Column(
            
          ),
        ),
      ),
      
    );
  }
}