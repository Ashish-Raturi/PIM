import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pim/home/note/note_tile.dart';
import 'package:pim/models/note_data.dart';
import 'package:pim/service/database/notes.dart';
import 'package:pim/shared/show_Toast.dart';
import 'package:provider/provider.dart';

class NoteList extends StatefulWidget {
  final String uid;
  NoteList({this.uid});
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<List<NotesData>>(context) ?? [];
    return StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: notes.length,
        staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        itemBuilder: (BuildContext context, int index) {
          return NoteTile(note: notes[index]);
        });
    // return ListView.builder(
    //   itemCount: notes.length,
    //   itemBuilder: (BuildContext context, int index) {
    //     return NoteTile(note: notes[index]);
    //   },
    // );
  }
}
