import 'dart:js';

import 'package:flutter/material.dart';

class UpcomingClubs extends StatelessWidget {
  const UpcomingClubs({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 8,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index){
        return Container(
          margin: EdgeInsets.symmetric(
            horizontal: 15, vertical: 5,
          ),
        );
      },
    );
  }
}