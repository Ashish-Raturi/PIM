import 'package:flutter/material.dart';
import 'package:pim/home/task/add_edit_task.dart';
import 'package:pim/home/task/task_list.dart';
import 'package:pim/models/task_data.dart';
import 'package:pim/service/database/task.dart';
import 'package:pim/shared/constants.dart';
import 'package:provider/provider.dart';

class TaskPage extends StatefulWidget {
  final user;
  TaskPage({this.user});
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<TaskData>>.value(
      value: TaskDbService(uid: widget.user.uid).getTaskData,
      child: Scaffold(
          body: TaskList(uid: widget.user.uid),
          floatingActionButton: FloatingActionButton(
              backgroundColor: c2,
              child: Tooltip(
                message: 'Add Task',
                child: Icon(
                  Icons.add,
                ),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddEditTask(
                              add: true,
                            )));
              })),
    );
  }
}
