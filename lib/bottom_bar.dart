import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:share/share.dart';

Widget BottomBarWidget(BuildContext context) {
  return Container(
    height: 55.0,
    child: BottomAppBar(
      color: Color.fromRGBO(58, 66, 86, 1.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite, color: Colors.white),
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) => modalInfoSheet(context));
            },
          ),
        ],
      ),
    ),
  );
}

Widget modalInfoSheet(BuildContext context) {
  return Container(
    color: Colors.transparent,
    child: Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(15),
            topRight: const Radius.circular(15),
          )),
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            height: 50,
            width: 250,
            child: new RaisedButton(
              color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Icon(Icons.stars, color: Colors.white),
                  new Text("Feedback",
                      style: TextStyle(color: Colors.white, fontSize: 22)),
                ],
              ),
              onPressed: () {},
            ),
          ),
          Container(
            height: 50,
            width: 250,
            child: new RaisedButton(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Icon(Icons.share, color: Colors.blue),
                  new Text("Teilen",
                      style: TextStyle(color: Colors.blue, fontSize: 22)),
                ],
              ),
              onPressed: () {
                openShared();
              },
            ),
          ),
        ],
      ),
    ),
  );
}

void openShared() {
  Share.share("Download Sira from the AppStore or Google Play!");
}
