import 'package:flutter/material.dart';

class OngoingClub extends StatelessWidget {
  const OngoingClub({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xFFE7E4D3)
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '3:00 PM', 
                style: TextStyle(
                  color: Colors.green),
                  ),
                  SizedBox(width: 20,),
                  Flexible(child: Text('My House', style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                  ))
            ],
          ),
          Divider(),
          Row(
            children: [
              Text(
                '4:00 PM', 
                style: TextStyle(
                  color: Colors.green),
                  ),
                  SizedBox(width: 20,),
                  Flexible(child: Text('My House', style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                  ))
            ],
          ),
          Divider(),
          Row(
            children: [
              Text(
                '5:00 PM', 
                style: TextStyle(
                  color: Colors.green),
                  ),
                  SizedBox(width: 20,),
                  Flexible(child: Text('My House', style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                  ))
            ],
          ),
        ],
      ),
    );
  }
}