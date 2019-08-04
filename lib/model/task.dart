import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Task {
  final String taskName;
  final DateTime dueDate;
  final Priority priority;

  Task({
    @required this.taskName,
    @required this.dueDate,
    @required this.priority,
  });

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

}

enum Priority {
  low,
  medium,
  high,
  urgent
}