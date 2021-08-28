import 'package:flutter/material.dart';

class AboutPopup extends StatefulWidget {
  const AboutPopup({ Key? key }) : super(key: key);

  @override
  _AboutPopupState createState() => _AboutPopupState();
}

class _AboutPopupState extends State<AboutPopup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us') ,
      ),
      body : SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 8, bottom: 4),
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "App Info",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Card(
                    child:Container(
                      child: Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.all(15),
                        child: Column(children: <Widget>[
                          Column(
                            children:<Widget>[
                              ...ListTile.divideTiles(
                                color: Colors.grey,
                                tiles: [
                                  ListTile(
                                    leading: Icon(Icons.info),
                                   title: Text('App Name'),
                                    subtitle: Text('My House'),
                                    ),
                                  
                                  ListTile(
                                    leading: Icon(Icons.info),
                                    title: Text('App'),
                                    subtitle: Text('ClubHouse Clone'),
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.phone_android),
                                    title: Text('Version'),
                                    subtitle: Text('1.0.0'),
                                  ),
                                ]
                              )
                            ]
                          )
                        ],)
                      ),
                      )
                  ),
                  SizedBox(height: 40),
                  Container(
                    padding: EdgeInsets.only(left: 8, bottom: 4),
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Developer",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Card(
                    child:Container(
                      child: Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.all(15),
                        child: Column(children: <Widget>[
                          Column(
                            children:<Widget>[
                              ...ListTile.divideTiles(
                                color: Colors.grey,
                                tiles: [
                                  ListTile(
                                    leading: Icon(Icons.person),
                                    title: Text('Munyaradzi Chigangawa'),
                                    subtitle: Text('Chinhoyi, Zimbabwe'),
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.work),
                                    title: Text('Occupation'),
                                    subtitle: Text('Software Developer'),
                                  ),
                                ]
                              )
                            ]
                          )
                        ],)
                      ),
                      )
                  )
                ],
              ))
        ],
      )),
      );
  }
}
    
  