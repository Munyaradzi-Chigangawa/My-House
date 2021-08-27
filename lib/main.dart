import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_house/models/userModel.dart';
import 'package:my_house/screens/authScreen.dart';
import 'package:my_house/screens/home.dart';
import 'screens/notInvited.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My House',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthenticateUser(),
    );
  }
}

class AuthenticateUser extends StatelessWidget {

    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

    Future chechCurrentUser() async {
      
      if (_firebaseAuth.currentUser != null){

         var userInvited = await FirebaseFirestore.instance
             .collection('invites')
             .where('invitee', 
             isEqualTo: _firebaseAuth.currentUser!.phoneNumber)
             .get();

             if (userInvited.docs.length < 1){
               return Notinvited();
             }

        var userExist = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', 
        isEqualTo: _firebaseAuth.currentUser!.uid)
        .get();

        UserModel user = UserModel.fromMap(userExist.docs.first);
        return Home(user: user);
      } else {
        return AuthScreen();
      }
    }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: chechCurrentUser(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting){
          return Container(
            color: Colors.blue,
            child: Center(
              child: CircularProgressIndicator(backgroundColor: Colors.white,),
            ),
          );
        } else {
          return snapshot.data;
        }
      },
    );
  }
}