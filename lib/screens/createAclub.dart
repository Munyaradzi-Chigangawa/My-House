import 'package:flutter/material.dart';
import 'package:my_house/models/userModel.dart';

class CreateAClub extends StatefulWidget {
  const CreateAClub({ Key? key, required this.user }) : super(key: key);
  final UserModel user;

  @override
  _CreateAClubState createState() => _CreateAClubState();
}

class _CreateAClubState extends State<CreateAClub> {

  final GlobalKey <FormState> _formKey = GlobalKey <FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create your Club'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                
              ],
            )
          ),
        )
      ),
    );
  }
}