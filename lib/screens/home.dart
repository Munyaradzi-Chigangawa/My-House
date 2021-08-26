import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_house/main.dart';
import 'package:my_house/models/userModel.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.user}) : super(key: key);
 final UserModel user;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text('Invite'),
              onTap: () {},
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
                    ));
                });
              }, 
              icon: Icon(Icons.power_settings_new_outlined))
        ],
      ),
      body: Container(),
    );
  }
}
