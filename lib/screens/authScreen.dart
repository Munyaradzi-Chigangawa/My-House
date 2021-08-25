import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_house/screens/home.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  bool isLoading = false;
  bool isOTPscreen = false;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance; 
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var verificationCode;

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }
  Future phoneAuth() async {
    var _phoneNumber = "+263" + phoneController.text.trim(); 
    setState(() {
      isLoading = true;
    });
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: _phoneNumber, 
      verificationCompleted: (PhoneAuthCredential credential){
        _firebaseAuth.signInWithCredential(credential).then((userData) async {
          // ignore: unnecessary_null_comparison
          if (userData != null) {
            await _firestore.collection('users').doc(userData.user!.uid).set({
              'name': '',
              'phone': userData.user!.phoneNumber,
              'uid': userData.user!.uid,
              'invitesLeft':10,
            });

            setState(() {
              isLoading = false;
            });
            // Navigate to home Screen
          }
        });
      }, 
      verificationFailed: (FirebaseAuthException error) {
        print("firebase Error : ${error.message}");
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          isLoading = false;
          isOTPscreen = true;
          verificationCode = verificationId;
        });
      }, 
      codeAutoRetrievalTimeout: (String verificationId){
        setState(() {
          isLoading = false;
          verificationCode = verificationId;
        });
      }, timeout: Duration(seconds: 120)
    );
  }

  Future otpSignIn() async {
    setState(() {
      isLoading = true;
    });
    try{
      _firebaseAuth.signInWithCredential(
        PhoneAuthProvider.credential(
          verificationId: verificationCode,
          smsCode: otpController.text.trim(),
          )
        ).then((userData){
          // ignore: unnecessary_null_comparison
          if (userData != null) {
            setState(() {
              isLoading = false;
            });
            print('Login Successful');
            // Navigate
          }
        });
    }catch(e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blue,
      ),
      child: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 60),
              height: 150,
              child: Text(
                'My House',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60),
                  topRight: Radius.circular(60),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 60,),
                    Icon(
                      Icons.connect_without_contact,
                      size: 60,
                      color: Colors.blue,
                    ),
                    SizedBox(height: 30,),
                    Text(
                      'Login with phone',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                      ),
                    ),
                     isOTPscreen ? Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                      child: TextField(
                        controller: otpController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Enter OTP',
                            hintText: 'Enter OTP you received.'),
                      ),
                    ) :
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                      child: TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Enter Phone Number',
                            hintText: 'Enter your invited phone number'),
                      ),
                    ),
                    SizedBox(height:30),
                    isLoading ? CircularProgressIndicator() : Container(
                      height: 50,
                      width: 250,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => Theme.of(context).primaryColor)),
                onPressed: () {
                  isOTPscreen ? otpSignIn() : phoneAuth();
                  // Navigator.push(
                  //     context, MaterialPageRoute(builder: (_) => Home()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Login',
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ]
                    )
                      ),)
                  ],
                ),
              ),
            ))
          ],
        ),
      ),)
    );
  }
}
