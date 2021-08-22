import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(onPressed: () {}, 
          icon: Icon(Icons.power_settings_new_outlined)
          )
        ],
      ),
      body: Container(),
    );
  }
}