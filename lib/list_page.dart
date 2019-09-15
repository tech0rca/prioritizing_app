import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prioritizing_app/app_builder.dart';
import 'package:prioritizing_app/custom_dialog.dart';
import 'package:prioritizing_app/data_service.dart';
import 'package:prioritizing_app/database_helper.dart';
import 'package:prioritizing_app/model/task.dart';
import 'package:sqflite/sqlite_api.dart';

class ListPage extends StatefulWidget {
  ListPage({Key key, this.task}) : super(key: key);
  final Task task;

  @override
  State<StatefulWidget> createState() {
    return _ListPageState();
  }
}

  class _ListPageState extends State<ListPage> {
  Future<List<Task>> taskListFuture;
  DatabaseHelper db;

  @override
  void initState() {
    super.initState();
    db = DatabaseHelper.instance;
    refreshList();

  }

  refreshList() {
    setState(() {
      taskListFuture = db.getAllTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBuilder(builder: (context) {
      return Scaffold(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        appBar: topAppBar(context),
        body: _taskListView(context),
        bottomNavigationBar: makeBottom,
      );
    });
  }
  Widget _taskListView(
      BuildContext context) {
    return FutureBuilder<List<Task>>(
      future: taskListFuture,
      builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
        if (snapshot.hasData) {
          return dataTable(snapshot.data);
        }
        if (null == snapshot.data || snapshot.data.length == 0) {
          return addSomeTasksText();
        }
        return CircularProgressIndicator();
      },
    );
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
              refreshList();
              //AppBuilder.of(context).rebuild();
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

  addSomeTasksText() {
    return Center(
      child: Container(child: new Text(
        'Add Some Tasks!',
        style: new TextStyle(
          color: Colors.white,
          fontSize: 40.0,
          fontWeight: FontWeight.w200)
      ),
      ),
    );
  }
  dataTable(List<Task> taskList) {
          return ListView.builder(
            itemCount: taskList.length,
            itemBuilder: (context, index) {
              return Dismissible(
                  child: Card(
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
                      )),
                  key: new Key(taskList[index].id.toString()),
                  onDismissed: (direction) {
                    setState(() {
                      db.delete(taskList[index].id);
                      taskList.removeAt(index);
                    });
                    //refreshList();
                  });
            },
          );
  }





}
