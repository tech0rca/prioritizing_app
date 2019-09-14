import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:prioritizing_app/list_page.dart';
import 'package:sqflite/sqflite.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(58, 66, 86, 1.0),
        primarySwatch: Colors.blue,
      ),
      home: ListPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.map),
              title: Text('Map')
            ),
            ListTile(
              leading: Icon(Icons.photo_album),
              title: Text('Map')
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('Map')
            ),
            
          ],
        ),
      ),
    );
  }
}
