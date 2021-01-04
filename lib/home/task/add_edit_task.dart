import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pim/models/pim_user.dart';
import 'package:pim/models/task_data.dart';
import 'package:pim/service/database/task.dart';
import 'package:pim/shared/constants.dart';
import 'package:pim/shared/show_Toast.dart';
import 'package:provider/provider.dart';

class AddEditTask extends StatefulWidget {
  final bool add;
  final TaskData taskData;
  AddEditTask({this.add, this.taskData});
  @override
  _AddEditTaskState createState() => _AddEditTaskState();
}

class _AddEditTaskState extends State<AddEditTask> {
  String _currentTitle;
  DateTime _currentDate;
  String _currentTask;
  bool _isDone;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _currentTitle = widget.add ? 'Add Task' : 'Edit Task';
    if (widget.add) {
      _currentDate = DateTime.now();
      _currentTask = '';
      _isDone = false;
    } else {
      _currentDate = DateTime.parse(widget.taskData.date);
      _currentTask = widget.taskData.task;
      _isDone = widget.taskData.isDone ?? false;
    }
  }

  //DatePicker
  Future<DateTime> _selectDate(DateTime currentDate) async {
    DateTime _pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime.now().subtract(Duration(days: 365)),
        lastDate: DateTime.now().add(Duration(days: 365)));

    if (_pickedDate != null) {
      return _pickedDate;
    } else {
      return currentDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    final PimUser user = Provider.of<PimUser>(context);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            _currentTitle,
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            !widget.add
                ? IconButton(
                    onPressed: () async {
                      await TaskDbService(uid: user.uid)
                          .deleteTask(widget.taskData.docId)
                          .whenComplete(() => Navigator.pop(context));
                      showToast('Task Deleted', context);

                      print('deleted');
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  )
                : Container(),
          ],
        ),
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //DropDown
                      FlatButton(
                        padding: EdgeInsets.all(0.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: 22.0,
                              color: c2,
                            ),
                            SizedBox(
                              width: 16.0,
                            ),
                            Text(DateFormat.yMMMEd().format(_currentDate)),
                            Icon(
                              Icons.arrow_drop_down,
                              color: c2,
                            )
                          ],
                        ),
                        onPressed: () async {
                          DateTime pickedDate = await _selectDate(_currentDate);
                          setState(() {
                            _currentDate = pickedDate;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),

                      //Appointment
                      TextFormField(
                        initialValue: _currentTask,
                        validator: (val) =>
                            val.isEmpty ? "Enter Task Details" : null,
                        decoration: textInputDecoration.copyWith(
                            labelText: 'Task',
                            icon: Icon(
                              Icons.speaker_notes,
                              color: c2,
                            )),
                        onChanged: (val) {
                          setState(() {
                            _currentTask = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      CheckboxListTile(
                          title: Text(
                            _isDone ? 'Done' : 'Not Done',
                            style: TextStyle(
                                color: c1, fontWeight: FontWeight.w400),
                          ),
                          value: _isDone,
                          onChanged: (val) {
                            setState(() {
                              _isDone = val;
                            });
                          }),
                    ],
                  )),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
            icon: Image.asset('assets/icons/save.png',
                height: 20.0, width: 20.0, color: Colors.white),
            backgroundColor: c2,
            onPressed: () async {
              if (formKey.currentState.validate()) {
                if (widget.add) {
                  //add
                  await TaskDbService(uid: user.uid)
                      .addTask(_currentTask, _currentDate.toString(), false);

                  showToast('Task Added', context);
                } else {
                  //update
                  await TaskDbService(uid: user.uid).updateTask(_currentTask,
                      _currentDate.toString(), _isDone, widget.taskData.docId);

                  showToast('Task Edited', context);
                  print('Task added');
                }
                Navigator.pop(context);
              }
            },
            label: Text(
              'Save',
              style: TextStyle(color: Colors.white),
            )));
  }
}
