import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
