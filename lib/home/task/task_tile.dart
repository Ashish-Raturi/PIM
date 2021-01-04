import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pim/home/task/add_edit_task.dart';
import 'package:pim/models/task_data.dart';
import 'package:pim/shared/constants.dart';

class TaskTile extends StatefulWidget {
  final TaskData task;
  TaskTile({this.task});
  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) {
    String _title =
        DateFormat.yMMMMd().format(DateTime.parse(widget.task.date));
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Card(
        elevation: 4.0,
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 6.0),
        child: ListTile(
          title: Text(
            widget.task.task,
            style: TextStyle(
                decoration: widget.task.isDone
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            _title,
            style: TextStyle(color: c3, fontWeight: FontWeight.bold),
          ),
          trailing: Text(
            widget.task.isDone ? 'Done' : 'Not\nDone',
            style: TextStyle(color: c2, fontWeight: FontWeight.w400),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddEditTask(
                          add: false,
                          taskData: widget.task,
                        )));
          },
        ),
      ),
    );
  }
}
