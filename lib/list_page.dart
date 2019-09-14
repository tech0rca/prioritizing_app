import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prioritizing_app/app_builder.dart';
import 'package:prioritizing_app/custom_dialog.dart';
import 'package:prioritizing_app/data_service.dart';
import 'package:prioritizing_app/database_helper.dart';
import 'package:prioritizing_app/model/task.dart';
import 'package:sqflite/sqlite_api.dart';

class ListPage extends StatelessWidget {
  ListPage({Key key, this.task}) : super(key: key);
  final Task task;

  DataService dataService = new DataService();
  DatabaseHelper db = DatabaseHelper.instance;

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

  Widget _taskListView(
      BuildContext context) {
    return FutureBuilder<List<Task>>(
      future: db.getAllTasks(),
      builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {

      switch (snapshot.connectionState) {
        case ConnectionState.none:
          return Text('Press button to start.');
        case ConnectionState.active:
        case ConnectionState.waiting:
          return Text('Awaiting result...');
        case ConnectionState.done:
          if (snapshot.hasError)
            return Text('Error: ${snapshot.error}', style: new TextStyle(color: Colors.white),);
          return ListView.builder(
            itemCount: snapshot.data.length,
            key: key,
            itemBuilder: (context, index) {
              return Dismissible(
                  child: Card(
                      color: snapshot.data[index].returnPriorityColor(),
                      child: Padding(
                        child: Row(
                          children: <Widget>[
                            Text(
                              snapshot.data[index].getTaskName,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w200),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(10.0),
                      )),
                  key: new Key(snapshot.data[index].id),
                  onDismissed: (direction) {
                    dataService.removeTask(snapshot.data[index]);
                  });
            },
          );
      }
      },
    );
  }
}
