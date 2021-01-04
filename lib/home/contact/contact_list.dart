import 'package:flutter/material.dart';
import 'package:pim/home/contact/contact_tile.dart';
import 'package:pim/models/contact_data.dart';
import 'package:pim/service/database/contact.dart';
import 'package:pim/shared/constants.dart';
import 'package:pim/shared/show_Toast.dart';
import 'package:provider/provider.dart';

class ShowListView extends StatefulWidget {
  final String uid;
  ShowListView({this.uid});
  @override
  _ShowListViewState createState() => _ShowListViewState();
}

class _ShowListViewState extends State<ShowListView> {
  @override
  Widget build(BuildContext context) {
    final contacts = Provider.of<List<ContactData>>(context) ?? [];
    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (BuildContext context, int index) {
        return ShowListTile(contact: contacts[index]);
      },
    );
  }
}
