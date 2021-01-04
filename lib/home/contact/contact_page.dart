import 'package:flutter/material.dart';
import 'package:pim/home/contact/add_edit_contact.dart';
import 'package:pim/home/contact/contact_list.dart';
import 'package:pim/models/contact_data.dart';
import 'package:pim/service/database/contact.dart';
import 'package:pim/shared/constants.dart';
import 'package:provider/provider.dart';

class ContactPage extends StatelessWidget {
  final user;
  ContactPage({this.user});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<ContactData>>.value(
        value: ContactDbService(uid: user.uid).getContactData,
        child: Scaffold(
            body: ShowListView(uid: user.uid),
            floatingActionButton: FloatingActionButton(
                backgroundColor: c2,
                child: Tooltip(
                  message: 'Add Contact',
                  child: Icon(
                    Icons.add,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddEditContact(
                                add: true,
                              )));
                })));
  }
}
