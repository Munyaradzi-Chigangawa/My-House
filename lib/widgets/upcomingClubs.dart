
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_house/models/club.dart';
import 'package:my_house/models/userModel.dart';
import 'package:my_house/screens/clubScreen.dart';

class UpcomingClubs extends StatelessWidget {
  const UpcomingClubs({Key? key, required this.user}) : super(key: key);
  final UserModel user;
  

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('clubs')
            .where('status', isEqualTo: 'new')
            .where('dateTime',
                isLessThan: DateTime.now().add(Duration(days: 7))).get(),
        builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs.length < 1) {
              return Container(
                margin: EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    Icon(Icons.face_sharp),
                    Text("No Clubs available"),
                    Text("Create your own club")
                  ],
                ),
              );
            }
          
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index){
              var data = snapshot.data!.docs[index];
              Club clubDetail = new Club.fromMap(data);
              DateTime dateTime = DateTime.parse(clubDetail.dateTime.toDate().toString());
              var formattedDateTime = DateFormat.MMMd().add_jm().format(dateTime);

              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => ClubScreen(user: user, club: clubDetail),
                  ));
                },
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 15, vertical: 5,
                  ),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${clubDetail.title}", style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Icon(Icons.wysiwyg),
                              SizedBox(width: 5,),
                              Text("${clubDetail.category}"),
                              SizedBox(width: 20,),
                              Icon(Icons.calendar_today_rounded),
                              SizedBox(width: 5,),
                              Text("$formattedDateTime")
                            ],
                          ),
                          SizedBox(height: 15,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.person),
                              SizedBox(width: 20,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: clubDetail.speakers.map((speaker) => Text(speaker.values.last)).toList(),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            });
        }
          return Container(
            height: 300,
            child: Center(
              child: CircularProgressIndicator(),
              ),
          );
        });
  }
}
