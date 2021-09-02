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
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), 
            ),
            child: Padding(padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Flutter and Firebase',
                style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10,),
              ],
            ),
            ),
          ),
        );
      },
    );
  }
}