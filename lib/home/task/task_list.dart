import 'package:flutter/material.dart';
import 'package:pim/home/task/task_tile.dart';
import 'package:pim/models/task_data.dart';
import 'package:provider/provider.dart';

class TaskList extends StatefulWidget {
  final String uid;
  TaskList({this.uid});
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<List<TaskData>>(context) ?? [];
    // tasks.sort();

    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (BuildContext context, int index) {
        return TaskTile(task: tasks[index]);
      },
    );
  }
}
