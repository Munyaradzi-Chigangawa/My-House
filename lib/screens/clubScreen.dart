import 'package:flutter/material.dart';
import 'package:my_house/models/club.dart';
import 'package:my_house/models/userModel.dart';

class ClubScreen extends StatefulWidget {
  const ClubScreen({ Key? key, required this.user, required this.club }) : super(key: key);
  final UserModel user;
  final Club club;
  ClubScreen(this.club, this.user);
  

  @override
  _ClubScreenState createState() => _ClubScreenState();
}

class _ClubScreenState extends State<ClubScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}