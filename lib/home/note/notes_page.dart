import 'package:flutter/material.dart';
import 'package:pim/home/note/add_edit_note.dart';
import 'package:pim/home/note/note_list.dart';
import 'package:pim/models/note_data.dart';
import 'package:pim/service/database/notes.dart';
import 'package:pim/shared/constants.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatelessWidget {
  final user;
  NotesPage({this.user});
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<NotesData>>.value(
      value: NoteDbService(uid: user.uid).getNoteData,
      child: Scaffold(
          body: NoteList(uid: user.uid),
          floatingActionButton: FloatingActionButton(
              backgroundColor: c2,
              child: Tooltip(
                message: 'Add Note',
                child: Icon(
                  Icons.add,
                ),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddEditNote(
                              add: true,
                            )));
              })),
    );
  }
}
