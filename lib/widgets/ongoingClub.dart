import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class OngoingClub extends StatelessWidget {
  const OngoingClub({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Color(0xFFE7E4D3)),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('clubs')
            .where('status', isEqualTo: 'ongoing')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData){
            if (snapshot.data!.docs.length < 0) {
              return Container(
                width: double.infinity,
                child: Text('No ongoing club at the moment')
              );
            }

          }
          return LinearProgressIndicator();
        },
      ),
    );
  }
}
