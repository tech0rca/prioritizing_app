import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class Task {
  String id;
  String taskName;
  DateTime dueDate;
  Priority priority;

  Task();


  get getTaskName => taskName;

  Color returnPriorityColor() {
    switch (this.priority) {
      case Priority.low:
        return Colors.green;
        break;
      case Priority.medium:
        return Colors.blue;
        break;
      case Priority.high:
        return Colors.orange;
        break;
      case Priority.urgent:
        return Colors.red;
        break;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'taskname': taskName,
      'dueDate': dueDate.toString(),
      'priority': priority.toString()
    };
  }

  Task.fromMap(Map<String, dynamic> map) {
    //TODO: Deserializing funktioniert noch nicht
    id = map[0];
    taskName = map[taskName];
    dueDate = map[dueDate];
    priority = map[priority];
  }
}

enum Priority { low, medium, high, urgent }
