import 'model/task.dart';

class DataService {
  static final DataService _instance = DataService._internal();

  factory DataService() => _instance;
  List<Task> taskList;
  
  DataService._internal() {
    taskList = [];
  }

  void addTask(task) {
    taskList.add(task);
  }

  List<Task> getTaskList() {
    taskList.sort((task1, task2) => task1.priority.index.compareTo(task2.priority.index));
    taskList = taskList.reversed.toList();
    return taskList;
  }
}