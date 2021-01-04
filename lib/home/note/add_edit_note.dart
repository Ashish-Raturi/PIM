import 'package:flutter/material.dart';
import 'package:pim/models/note_data.dart';
import 'package:pim/models/pim_user.dart';
import 'package:pim/service/database/notes.dart';
import 'package:pim/shared/colorList.dart';
import 'package:pim/shared/constants.dart';
import 'package:pim/shared/show_Toast.dart';
import 'package:provider/provider.dart';

class AddEditNote extends StatefulWidget {
  final bool add;
  final NotesData notesData;
  AddEditNote({this.add, this.notesData});
  @override
  _AddEditNoteState createState() => _AddEditNoteState();
}

class _AddEditNoteState extends State<AddEditNote> {
  String _title;
  String _note;
  String _appBarTitle;
  String _selectedColor;
  List<Color> colors = [
    Colors.white,
    Colors.brown,
    Colors.deepOrange,
    Colors.deepPurple,
    Colors.green,
    Colors.indigo,
    Colors.lime,
    Colors.pink,
    Colors.red,
    Colors.teal,
    Colors.amber,
  ];
  FocusNode textSecondFocusNode = new FocusNode();
  var _controller1;
  var _controller2 = TextEditingController();
  @override
  void initState() {
    super.initState();
    _appBarTitle = widget.add ? 'Add Note' : 'Edit Note';
    if (widget.add) {
      _title = '';
      _note = '';
      _controller1 = TextEditingController(text: _title);
      _controller2 = TextEditingController(text: _note);
      _selectedColor = "1";
    } else {
      _title = widget.notesData.title;
      _controller1 = TextEditingController(text: _title);
      _note = widget.notesData.note;
      _controller2 = TextEditingController(text: _note);
      _selectedColor = widget.notesData.colorIndex;
    }
  }

  changeSelctedColor(String color) {
    setState(() {
      _selectedColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    final PimUser user = Provider.of<PimUser>(context);
    return Scaffold(
        backgroundColor: colors[int.parse(_selectedColor) - 1],
        appBar: AppBar(
          backgroundColor: colors[int.parse(_selectedColor) - 1],
          iconTheme: IconThemeData(
            color: _selectedColor == '1' ? Colors.black : Colors.white,
          ),
          elevation: 0.0,
          centerTitle: true,
          title: Text(_appBarTitle,
              style: TextStyle(
                color: _selectedColor == '1' ? Colors.black : Colors.white,
              )),
          actions: [
            !widget.add
                ? IconButton(
                    onPressed: () async {
                      await NoteDbService(uid: user.uid)
                          .deleteNote(widget.notesData.docId)
                          .whenComplete(() => Navigator.pop(context));
                      showToast('Note Deleted', context);

                      print('deleted');
                    },
                    icon: Icon(
                      Icons.delete,
                      color:
                          _selectedColor == '1' ? Colors.black : Colors.white,
                    ),
                  )
                : Container(),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.,
              children: [
                SizedBox(height: 5.0),
                colorList(_selectedColor, changeSelctedColor),
                SizedBox(height: 5.0),
                TextField(
                  textInputAction: TextInputAction.next,
                  controller: _controller1,
                  keyboardType: TextInputType.text,
                  maxLines: null,
                  style: TextStyle(
                      color: _selectedColor == '1'
                          ? Colors.black54
                          : Colors.white70,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1),
                  cursorColor:
                      _selectedColor == '1' ? Colors.black : Colors.white,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                      hintText: 'Title',
                      hintStyle: TextStyle(
                          color: _selectedColor == '1'
                              ? Colors.black54
                              : Colors.white70,
                          fontSize: 22.0,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1),
                      border: InputBorder.none),
                  onChanged: (val) {
                    setState(() {
                      _title = val;
                    });
                  },
                  onSubmitted: (val) {
                    FocusScope.of(context).requestFocus(textSecondFocusNode);
                  },
                ),
                SizedBox(height: 5.0),

                //Number
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: TextField(
                    expands: true,
                    controller: _controller2,
                    keyboardType: TextInputType.multiline,
                    focusNode: textSecondFocusNode,
                    maxLines: null,
                    style: TextStyle(
                        color: _selectedColor == '1'
                            ? Colors.black54
                            : Colors.white70,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1),
                    cursorColor:
                        _selectedColor == '1' ? Colors.black : Colors.white,
                    decoration: InputDecoration(
                        hintText: 'Notes',
                        contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                        hintStyle: TextStyle(
                            color: _selectedColor == '1'
                                ? Colors.black54
                                : Colors.white70,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1),
                        border: InputBorder.none),
                    onChanged: (val) {
                      setState(() {
                        _note = val;
                      });
                    },
                  ),
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
            icon: Image.asset(
              'assets/icons/save.png',
              height: 20.0,
              width: 20.0,
              color: colors[int.parse(_selectedColor) - 1],
            ),
            backgroundColor: _selectedColor == '1' ? c2 : Colors.white,
            onPressed: () async {
              if (_title.isEmpty && _note.isEmpty) {
                print('Emty Note distroyed');
                showToast('Emty Note distroyed', context);
              } else {
                if (widget.add) {
                  //add
                  await NoteDbService(uid: user.uid)
                      .addNote(_title, _note, _selectedColor);

                  showToast('Note Added', context);
                  print(_selectedColor);
                } else {
                  //update
                  await NoteDbService(uid: user.uid).updateNote(
                      _title, _note, widget.notesData.docId, _selectedColor);
                  showToast('Note Edited', context);
                  print('Note added');
                }
              }
              Navigator.pop(context);
            },
            label: Text(
              'Save',
              style: TextStyle(color: colors[int.parse(_selectedColor) - 1]),
            )));
  }
}
