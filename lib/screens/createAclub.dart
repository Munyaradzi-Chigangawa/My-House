import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:my_house/models/userModel.dart';

class CreateAClub extends StatefulWidget {
  const CreateAClub({Key? key, required this.user}) : super(key: key);
  final UserModel user;

  @override
  _CreateAClubState createState() => _CreateAClubState();
}

class _CreateAClubState extends State<CreateAClub> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _speakerController = TextEditingController();
  List<String> categories = [];
    List<String> speakers = [];
  String selectedCategory = "";

  @override
  void initState() {
  fetchCategories();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future fetchCategories() async {
    FirebaseFirestore.instance.collection('categories').get().then((value) {
      value.docs.forEach((element) {
        categories.add(element.data()['title']);
      });
      setState(() {});
    });
  }

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
                TextFormField(
                  validator: (value) {
                    if (value == '') {
                      return "Field is required";
                    }
                    return null;
                  },
                  controller: _titleController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Discussion Topic/Title',
                      labelText: 'Enter Discussion Topic/Title'),
                ),
                SizedBox(height: 30,),
                 DropDown<String>(
                  hint: Text('Select Category'),
                  items: categories,
                  onChanged: (value) {
                     selectedCategory = value;
                  },
                ),
                SizedBox(height: 20,),
               Row(
                 children: [
                   Expanded(child: TextField(
                     keyboardType: TextInputType.phone,
                     controller: _speakerController,
                     decoration: InputDecoration(
                       border: OutlineInputBorder(),
                       hintText: 'Invite Speakers (Optional)',
                       helperText: 'eg : +26377*******'
                     ),
                   )),
                   SizedBox(width: 10,),
                   ElevatedButton(
                     onPressed: () {
                       FirebaseFirestore.instance.collection('users').where('phone', isEqualTo: _speakerController.text).get().then((value){
                         if (value.docs.length > 0){
                           speakers.add(_speakerController.text);

                           _speakerController.text = '';
                           setState(() {
                             
                           });
                         } else {
                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                             backgroundColor: Colors.black,
                             content: Text('No User Found',
                           style: TextStyle(
                             color: Colors.white,
                           ),
                           )));
                         }
                       });
                     }, 
                     child: Text('Add'))
                 ],
               ),
               SizedBox()
              ],
            )),
      )),
    );
  }
}
