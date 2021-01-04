import 'package:flutter/material.dart';
import 'package:pim/home/contact/add_edit_contact.dart';
import 'package:pim/models/contact_data.dart';
import 'package:pim/shared/constants.dart';

class ShowListTile extends StatelessWidget {
  final ContactData contact;

  ShowListTile({this.contact});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Card(
          elevation: 4.0,
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 6.0),
          child: ListTile(
              leading: CircleAvatar(
                backgroundColor: c1,
                child: Text(
                  contact.name.substring(0, 1).toUpperCase(),
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
              title: Text(
                contact.name,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
              ),
              subtitle: Text(
                contact.pn,
                style: TextStyle(
                    fontSize: 15.0, color: c3, fontWeight: FontWeight.w400),
              ),
              onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddEditContact(
                                  contactData: contact,
                                  add: false,
                                )))
                  })),
    );
  }
}
