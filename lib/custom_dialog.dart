import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model/task.dart';

class CustomDialog extends StatefulWidget {
  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  void radioButtonChanges(Priority value) {
    setState(() {
      _chosenPriority = value;
    });
  }


  TextEditingController inputController = new TextEditingController();
  Priority _chosenPriority = Priority.low;
  @override
  Widget build(BuildContext context) {
        return AlertDialog(
          title: Text("Name"),
          content: Column(
            children: <Widget>[
              TextField(
                controller: inputController,
              ),
              new Radio(
                value: Priority.low,
                groupValue: _chosenPriority,
                onChanged: radioButtonChanges,
              ),
              new Text(
                'Carnivore',
                style: new TextStyle(fontSize: 16.0),
              ),
              new Radio(
                value: Priority.medium,
                groupValue: _chosenPriority,
                onChanged: radioButtonChanges,
              ),
              new Text(
                'Herbivore',
                style: new TextStyle(
                  fontSize: 16.0,
                ),
              ),
              new Radio(
                value: Priority.high,
                groupValue: _chosenPriority,
                onChanged: radioButtonChanges,
              ),
              new Text(
                'Omnivore',
                style: new TextStyle(fontSize: 16.0),
              ),
            ],
          ),
          actions: <Widget>[
            MaterialButton(
              elevation: 5.0,
              child: Text("Submit"),
              onPressed: () {},
            )
          ],
        );
  }
}
