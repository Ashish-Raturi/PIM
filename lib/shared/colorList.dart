import 'package:flutter/material.dart';
import 'package:pim/shared/constants.dart';
import 'package:selectable_circle_list/selectable_circle_list.dart';

Widget colorList(String selectedColor, Function changeSelctedColor) {
  Color _circleBackground = gold;

  List<SelectableCircleItem> _buildItems() {
    return <SelectableCircleItem>[
      SelectableCircleItem(
          CircleAvatar(
            radius: 20.0,
            backgroundColor: Colors.white,
          ),
          '',
          "1",
          _circleBackground),
      SelectableCircleItem(
          CircleAvatar(
            radius: 20.0,
            backgroundColor: Colors.brown,
          ),
          "",
          "2",
          _circleBackground),
      SelectableCircleItem(
          CircleAvatar(
            radius: 20.0,
            backgroundColor: Colors.deepOrange,
          ),
          "",
          "3",
          _circleBackground),
      SelectableCircleItem(
          CircleAvatar(
            radius: 20.0,
            backgroundColor: Colors.deepPurple,
          ),
          "",
          "4",
          _circleBackground),
      SelectableCircleItem(
          CircleAvatar(
            radius: 20.0,
            backgroundColor: Colors.green,
          ),
          "",
          "5",
          _circleBackground),
      SelectableCircleItem(
          CircleAvatar(
            radius: 20.0,
            backgroundColor: Colors.indigo,
          ),
          "",
          "6",
          _circleBackground),
      SelectableCircleItem(
          CircleAvatar(
            radius: 20.0,
            backgroundColor: Colors.lime,
          ),
          "",
          "7",
          _circleBackground),
      SelectableCircleItem(
          CircleAvatar(
            radius: 20.0,
            backgroundColor: Colors.pink,
          ),
          "",
          "8",
          _circleBackground),
      SelectableCircleItem(
          CircleAvatar(
            radius: 20.0,
            backgroundColor: Colors.red,
          ),
          "",
          "9",
          _circleBackground),
      SelectableCircleItem(
          CircleAvatar(
            radius: 20.0,
            backgroundColor: Colors.teal,
          ),
          "",
          "10",
          _circleBackground),
      SelectableCircleItem(
          CircleAvatar(
            radius: 20.0,
            backgroundColor: Colors.amber,
          ),
          '',
          "11",
          _circleBackground),
    ];
  }

  _onTapCircle(String value, String subvalue) {
    changeSelctedColor(value);
    // print("tapped $value");
  }

  return Container(
    width: double.infinity,
    height: 80.0,
    child: ListView(
      children: <Widget>[
        SelectableCircleList(
          canMultiselect: false,
          children: _buildItems(),
          onTap: _onTapCircle,
          initialValue: selectedColor,
          itemWidth: 75.0,
        ),
      ],
    ),
  );
}
