import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_house/models/club.dart';

class UpcomingClubs extends StatelessWidget {
  const UpcomingClubs({Key? key}) : super(key: key);

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

              return Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 15, vertical: 5,
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
