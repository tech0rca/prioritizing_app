import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prioritizing_app/data_service.dart';
import 'package:prioritizing_app/database_helper.dart';
import 'package:uuid/uuid.dart';

import 'list_page.dart';
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
          title: Text("Task name"),
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
                'Low',
                style: new TextStyle(fontSize: 16.0),
              ),
              new Radio(
                value: Priority.medium,
                groupValue: _chosenPriority,
                onChanged: radioButtonChanges,
              ),
              new Text(
                'Medium',
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
                'High',
                style: new TextStyle(fontSize: 16.0),
              ),
              new Radio(
                value: Priority.urgent,
                groupValue: _chosenPriority,
                onChanged: radioButtonChanges,
              ),
              new Text(
                'Urgent',
                style: new TextStyle(fontSize: 16.0),
              ),
            ],
          ),
          actions: <Widget>[
            MaterialButton(
              elevation: 5.0,
              child: Text("Submit"),
              onPressed: () {
                Task newTask = new Task(null, inputController.text, DateTime.parse("1969-07-20 20:18:04Z"), _chosenPriority);
                DatabaseHelper db = DatabaseHelper.instance;
                Future<int> id = db.insert(newTask);
                print('inserting data');
                id.then((val) => print(val));
                Navigator.pop(
                  context, newTask
                );
              },
            )
          ],
        );
  }
}
