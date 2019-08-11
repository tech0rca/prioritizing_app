import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prioritizing_app/app_builder.dart';
import 'package:prioritizing_app/custom_dialog.dart';
import 'package:prioritizing_app/data_service.dart';
import 'package:prioritizing_app/model/task.dart';

class ListPage extends StatelessWidget {
  ListPage({Key key, this.task}) : super(key: key);
  final Task task;

  DataService dataService = new DataService();

  @override
  Widget build(BuildContext context) {
    return AppBuilder(builder: (context) {
      return Scaffold(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        appBar: topAppBar(context),
        body: _taskListView(context, dataService.getTaskList()),
        bottomNavigationBar: makeBottom,
      );
    });
  }

  Widget topAppBar(BuildContext context) {
    return new AppBar(
      elevation: 0.1,
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      title: Text('Tasks'),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CustomDialog()),
              );
              AppBuilder.of(context).rebuild();
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

  Widget _taskListView(BuildContext context, List<Task> taskList) {
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
}
