

import 'package:cloud_firestore/cloud_firestore.dart';

class Club{
  String clubId;
  String title;
  String category;
  String createdBy;
  List speakers;
  Timestamp dateTime;
  String type;
  String status;

  Club({
   required this.clubId,
   required this.title,
   required this.category,
   required this.speakers,
  required this.dateTime,
   required this.createdBy,
   required this.status,
   required this.type,
  });

  factory Club.fromMap(QueryDocumentSnapshot documentSnapshot){
    return Club(
      clubId: documentSnapshot.id,
      title: documentSnapshot['title'],
      category: documentSnapshot['category'],
      createdBy: documentSnapshot['createdBy'],
      speakers: documentSnapshot['invited'],
      dateTime: documentSnapshot['dateTime'],
      type: documentSnapshot['type'],
      status: documentSnapshot['status'],
    );
  }
}