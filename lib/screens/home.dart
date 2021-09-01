import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_house/main.dart';
import 'package:my_house/models/userModel.dart';
import 'package:my_house/screens/createAclub.dart';
import 'package:my_house/screens/developer.dart';
import 'package:my_house/screens/invite.dart';
import 'package:my_house/screens/profile.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.user}) : super(key: key);
 final UserModel user;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    if(widget.user.name == ''){
      Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => Profile(user: widget.user,)));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
           Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAClub(user: widget.user)));
        },
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            SizedBox(height: 30,),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.share),
              title: Text('Invite'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => Invite(user: widget.user)));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.info_outlined),
              title: Text('About'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => AboutPopup()));
              },
            ),
             Divider(),
            ListTile(
              leading: Icon(Icons.power_settings_new_rounded),
              title: Text('Logout'),
              onTap: () async{
                Navigator.pop(context);
                FirebaseAuth.instance.signOut().then((value){
                  Navigator.pushReplacement(context, 
                  MaterialPageRoute(
                    builder: (context) => AuthenticateUser(),
                    )
                    );
                });
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
              onPressed: () async{
                FirebaseAuth.instance.signOut().then((value){
                  Navigator.pushReplacement(context, 
                  MaterialPageRoute(
                    builder: (context) => AuthenticateUser(),
                    )
                    );
                });
              }, 
              icon: Icon(Icons.power_settings_new_outlined))
        ],
      ),
      body: Container(),
    );
  }
}
