import 'package:flutter/material.dart';
import 'package:pim/home/note/add_edit_note.dart';
import 'package:pim/models/note_data.dart';
import 'package:snappable/snappable.dart';

class NoteTile extends StatefulWidget {
  final NotesData note;

  NoteTile({this.note});

  @override
  _NoteTileState createState() => _NoteTileState();
}

class _NoteTileState extends State<NoteTile> {
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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Card(
        elevation: 4.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        color: colors[int.parse(widget.note.colorIndex) - 1],
        child: Container(
          padding: const EdgeInsets.all(15.0),
          child: ListTile(
              title: widget.note.title.isNotEmpty
                  ? Text(
                      widget.note.title,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                        color: widget.note.colorIndex == '1'
                            ? Colors.black
                            : Colors.white,
                      ),
                      maxLines: 2,
                    )
                  : null,
              // isThreeLine: true,
              subtitle: widget.note.note.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Text(
                        widget.note.note,
                        maxLines: 11,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 15.0,
                            color: widget.note.colorIndex == '1'
                                ? Colors.black
                                : Colors.white,
                            fontWeight: FontWeight.w400),
                      ))
                  : null,
              onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddEditNote(
                                  notesData: widget.note,
                                  add: false,
                                )))
                  }),
        ),
      ),
    );
  }
}
