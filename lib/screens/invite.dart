import 'package:flutter/material.dart';


class Invite extends StatefulWidget {
  const Invite({ Key? key }) : super(key: key);

  @override
  _InviteState createState() => _InviteState();
}

class _InviteState extends State<Invite> {
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
            TextField(
              
            )
          ],
        ),),
    );
  }
}