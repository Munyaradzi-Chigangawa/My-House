import 'package:flutter/material.dart';

class OngoingClub extends StatelessWidget {
  const OngoingClub({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xfff1efe5)
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'time', 
                style: TextStyle(
                  color: Colors.black),
                  )
            ],
          )
        ],
      ),
    );
  }
}