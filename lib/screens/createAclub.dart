import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:my_house/models/userModel.dart';

class CreateAClub extends StatefulWidget {
  const CreateAClub({ Key? key, required this.user }) : super(key: key);
  final UserModel user;

  @override
  _CreateAClubState createState() => _CreateAClubState();
}

class _CreateAClubState extends State<CreateAClub> {

  final GlobalKey <FormState> _formKey = GlobalKey <FormState>();
  TextEditingController _titleController = TextEditingController();
  List <String> categories = [];
  String selectedCategory = '';

  @override
  void initState(){
    fetchCategories();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future fetchCategories() async {
    FirebaseFirestore.instance
    .collection('categories')
    .get()
    .then(
      (value) => value.docs
      .forEach(
        (element) {
          categories.add(element.data()['title']);
         }));
         setState(() {
           
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
                DropDown<String>(
                  hint: Text('Select Category'),
                  items: categories,
                  onChanged: (value) {
                    selectedCategory = value;
                  },
                ),
                SizedBox(height: 30,),
                TextFormField(
                  validator: (value){
                    if (value == '') {
                      return "Field is required";
                    }
                    return null;
                  },
                  controller: _titleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Discussion Topic/Title'
                  ),
                ),
              ],
            )
          ),
        )
      ),
    );
  }
}