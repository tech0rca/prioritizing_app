import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prioritizing_app/custom_dialog.dart';
import 'package:prioritizing_app/model/task.dart';

class ListPage extends StatefulWidget {
  ListPage({Key key, this.title}) : super(key: key);

  final String title;

  

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: topAppBar(context),
      body: BodyLayout(),
      bottomNavigationBar: makeBottom,
    );
  }
}

Widget topAppBar(BuildContext context) {
  return new AppBar(
    elevation: 0.1,
    backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
    title: Text('Tasks'),
    actions: <Widget>[
      IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => new CustomDialog(),
            );
          })
    ],
  );
}



final makeBottom = Container(
  height: 55.0,
  child: BottomAppBar(
    color: Color.fromRGBO(58, 66, 86, 1.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.home, color: Colors.white),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.blur_on, color: Colors.white),
          onPressed: () {},
        ),
      ],
    ),
  ),
);

class BodyLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _taskListView(context);
  }
}

Widget _taskListView(BuildContext context) {
  final List<Task> taskList = [];
  Task task4 = new Task(
      taskName: 'A low priority task',
      dueDate: DateTime.now(),
      priority: Priority.low);
  Task task1 = new Task(
      taskName: 'A high priority task',
      dueDate: DateTime.now(),
      priority: Priority.high);
  Task task2 = new Task(
      taskName: 'A medium priorty task2',
      dueDate: DateTime.now(),
      priority: Priority.medium);
  Task task3 = new Task(
      taskName: 'A urgent tasktask3',
      dueDate: DateTime.now(),
      priority: Priority.urgent);
  taskList.add(task1);
  taskList.add(task2);
  taskList.add(task3);
  taskList.add(task4);

  return ListView.builder(
    itemBuilder: (context, index) {
      return Card(
          color: taskList[index].returnPriorityColor(),
          child: Padding(
            child: Row(
              children: <Widget>[
                Text(
                  taskList[index].getTaskName,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w200),
                ),
              ],
            ),
            padding: const EdgeInsets.all(10.0),
          ));
    },
    itemCount: taskList.length,
  );
}
