import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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
  List<Map> speakers = [];
  String selectedCategory = "";
  late DateTime _dateTime;
  String type = "Private";

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
      backgroundColor: Color(0xfff1efe5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Create your Club',
          style: TextStyle(color: Colors.black),
        ),
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
                SizedBox(
                  height: 30,
                ),
                DropDown<String>(
                  hint: Text('Select Category'),
                  items: categories,
                  onChanged: (value) {
                    selectedCategory = value;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                        child: TextField(
                      keyboardType: TextInputType.phone,
                      controller: _speakerController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Invite Speakers (Optional)',
                          labelText: 'Invite Speakers (Optional)',
                          helperText: 'eg : +26377*******'),
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('users')
                              .where('phone',
                                  isEqualTo: _speakerController.text)
                              .get()
                              .then((value) {
                            if (value.docs.length > 0) {
                              speakers.add({
                                'name': value.docs.first.data()['name'],
                                'phone': _speakerController.text,
                              });

                              _speakerController.text = '';
                              setState(() {});
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      backgroundColor: Colors.redAccent,
                                      content: Text(
                                        'No User Found',
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
                SizedBox(
                  height: 20,
                ),
                ...speakers.map((user) {
                  var name = user.values.first;
                  var phone = user.values.last;
                  return ListTile(
                    leading: Icon(Icons.person),
                    title: Text(name),
                    subtitle: Text(phone),
                  );
                }),
                Text(
                  'Select Date and Time',
                  style: TextStyle(),
                ),
                SizedBox(
                  height: 180,
                  child: CupertinoDatePicker(
                    initialDateTime: DateTime.now(),
                    mode: CupertinoDatePickerMode.dateAndTime,
                    onDateTimeChanged: (DateTime dateTime) {
                      _dateTime = dateTime;
                    },
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text('Discussion Type: '),
                    Radio(
                        value: 'Private',
                        groupValue: type,
                        onChanged: (String? value) {
                          setState(() {
                            type = value!;
                          });
                        }),
                    Text(
                      'Private',
                      style: TextStyle(fontSize: 16),
                    ),
                    Radio(
                        value: 'Public',
                        groupValue: type,
                        onChanged: (String? value) {
                          setState(() {
                            type = value!;
                          });
                        }),
                    Text(
                      'Public',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () async {
                            if (selectedCategory == '') {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                backgroundColor: Colors.redAccent,
                                content: Text(
                                  'Select a category',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ));
                              return;
                            }
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              speakers.insert(0, {
                                'name': widget.user.name,
                                'phone': widget.user.phone,
                              });

                              await FirebaseFirestore.instance
                                  .collection('clubs')
                                  .add({
                                'title': _titleController.text,
                                'category': selectedCategory,
                                'createdBy': widget.user.phone,
                                'invited': speakers,
                                'createdOn': DateTime.now(),
                                'dateTime': _dateTime,
                                'type': type,
                                'status':
                                    'new' // new,ongoing,finished,cancelled
                              });
                              Navigator.pop(context);
                            }
                          },
                          child: Text(
                            'Create',
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ],
                )
              ],
            )),
      )),
    );
  }
}
