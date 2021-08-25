import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late String name;
  late String uid;
  late String phone;
  late int invitesLeft;

  UserModel({
    required this.name,
    required this.invitesLeft,
    required this.phone,
    required this.uid});

  factory UserModel.fromMap(QueryDocumentSnapshot documentSnapshot){
    return UserModel(
      name: documentSnapshot['name'],
      phone: documentSnapshot['phone'],
      invitesLeft: documentSnapshot['invitesLeft'],
      uid: documentSnapshot['uid'],
    );
  }
}