import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_house/models/userModel.dart';


class Invite extends StatefulWidget {
  const Invite({ Key? key, required this.user }) : super(key: key);
  final UserModel user;

  @override
  _InviteState createState() => _InviteState();
}

class _InviteState extends State<Invite> {
  final TextEditingController inviteController = TextEditingController();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isLoading = false;
  

  @override
  void dispose() {
    inviteController.clear();
    inviteController.dispose();
    super.dispose();
  }

  Future inviteFriends() async{
    if (inviteController.text.trim().length > 8){

      setState(() {
        isLoading = true;
      });
      _firestore.collection('invites')
      .add({
        'invitee': inviteController.text,
        'invitedBy': widget.user.phone,
        'date': DateTime.now(),
      }).then((value) {
        int invitesLeft = widget.user.invitesLeft! - 1;
        _firestore.collection('users').doc(widget.user.uid).update({
          'invitesLeft' : invitesLeft,
        }).then((value) {
          setState(() {
            widget.user.invitesLeft = invitesLeft;
            isLoading = false;
            inviteController.text = '';
          });
        });
      });
    }
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
              child: Text('${widget.user.invitesLeft}',
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
                inviteFriends();
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