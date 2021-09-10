
import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
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
            children: [
              SizedBox(height: 40,),
              Text(widget.club.title,style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
              Text(widget.club.category, style: TextStyle(fontSize: 10),),
              SizedBox(height: 50,),
              Row(
                children: [
                  Expanded(child: Divider()),
                  Text(' Speakers ', style: TextStyle(color: Colors.grey),),
                  Expanded(child: Divider()),
                ],
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance.collection('clubs').doc(widget.club.clubId).snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData){
                    var speakers = snapshot.data.data();
                    return Expanded(child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: speakers['invited'].length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.teal,
                            child: Icon(Icons.person,
                            color: Colors.white,
                            ),
                          ),
                          trailing: Icon(Icons.mic_off),
                          title: Text(speakers['invited'][index]['name']),
                        );
                      }
                      ));

                  }
                  return CircularProgressIndicator();
                })
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        height: 80,
        child: Row(
          children: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: Colors.amber,
              ),
              onPressed: (){}, 
              icon: Icon(Icons.exit_to_app), 
              label: Text('Exit Club'),
              )
          ],
        ),
      ),
      
    );
  }
}