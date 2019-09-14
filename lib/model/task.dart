import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class Task {
  int id;
  String taskName;
  DateTime dueDate;
  Priority priority;

  Task(this.id, this.taskName, this.dueDate, this.priority);


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
    id = map['id'];
    taskName = map['taskName'];
    dueDate = DateTime.parse(map['dueDate']);
    priority = deserializePriority(map['priority']);
    //priority = Priority.map['priority'];
  }

  deserializePriority(String statusText) {
    for (Priority element in Priority.values) {
      if (element.toString() == statusText) {
        return element;
      }
    }
    return null;
  }
}

enum Priority { low, medium, high, urgent }
