import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Invite extends StatefulWidget {
  const Invite({ Key? key }) : super(key: key);

  @override
  _InviteState createState() => _InviteState();
}

class _InviteState extends State<Invite> {
  final TextEditingController inviteController = TextEditingController();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  

  @override
  void dispose() {
    inviteController.clear();
    inviteController.dispose();
    super.dispose();
  }

  Future inviteFriends() async{
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invite your friends'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Center(
              child: Text('10',
              style: TextStyle(
                fontSize: 30,
              ), 
              ),
            ),
             Center(
              child: Text('Invites Left',
              style: TextStyle(
                fontSize: 30,
              ), 
              ),
            ),
            SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: TextField(
                controller: inviteController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Friend's mobile number with country code.",
                  hintText: "(eg: +26377*******)"
                ),
              ),
            ),
            SizedBox(height: 30,),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextButton(onPressed: () {

              }, 
              child: Text('Send Invite', 
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                ),)),
            ),
          ],
        ),),
    );
  }
}