import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pim/models/contact_data.dart';
import 'package:pim/models/pim_user.dart';
import 'package:pim/service/database/contact.dart';
import 'package:pim/shared/constants.dart';
import 'package:pim/shared/show_Toast.dart';
import 'package:provider/provider.dart';

class AddEditContact extends StatefulWidget {
  final bool add;
  final ContactData contactData;
  AddEditContact({this.add, this.contactData});
  @override
  _AddEditContactState createState() => _AddEditContactState();
}

class _AddEditContactState extends State<AddEditContact> {
  String _name;
  String _number;
  String _currentTitle;

  final formKey = GlobalKey<FormState>();
  FocusNode textSecondFocusNode = new FocusNode();

  @override
  void initState() {
    super.initState();
    _currentTitle = widget.add ? 'Add Contact' : 'Edit Contact';
    if (widget.add) {
      _name = '';
      _number = '';
    } else {
      _name = widget.contactData.name;
      _number = widget.contactData.pn;
    }
  }

  String validateMobile(String val) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);
    if (val.length == 0) {
      return 'Enter a mobile number';
    } else if (!regExp.hasMatch(val)) {
      return 'Enter valid 10 digit mobile number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final PimUser user = Provider.of<PimUser>(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(_currentTitle,
              style: TextStyle(
                color: Colors.white,
              )),
          actions: [
            !widget.add
                ? IconButton(
                    onPressed: () async {
                      await ContactDbService(uid: user.uid)
                          .deleteContact(widget.contactData.docId)
                          .whenComplete(() => Navigator.pop(context));
                      showToast('Contact Deleted', context);

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
                      SizedBox(height: 10.0),
                      //Name
                      TextFormField(
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        initialValue: _name,
                        validator: (val) => val.isEmpty ? "Enter a name" : null,
                        decoration: textInputDecoration.copyWith(
                            labelText: 'Name',
                            icon: Icon(
                              FontAwesomeIcons.solidUserCircle,
                              color: c2,
                            )),
                        onChanged: (val) {
                          setState(() {
                            _name = val;
                          });
                        },
                        onSaved: (val) {
                          FocusScope.of(context)
                              .requestFocus(textSecondFocusNode);
                        },
                      ),
                      SizedBox(height: 20.0),
                      //Number
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        initialValue: _number,
                        focusNode: textSecondFocusNode,
                        validator: (val) => validateMobile(val),
                        decoration: textInputDecoration.copyWith(
                            labelText: 'Phone Number',
                            icon: Icon(
                              FontAwesomeIcons.phoneAlt,
                              color: c2,
                            )),
                        onChanged: (val) {
                          setState(() {
                            _number = val;
                          });
                        },
                      ),
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
                if (widget.add == true) {
                  //add
                  await ContactDbService(uid: user.uid)
                      .addContact(_name, _number);
                  showToast('Contact Added', context);

                  print('Contact added');
                  Navigator.pop(context);
                } else {
                  //update
                  await ContactDbService(uid: user.uid)
                      .updateContact(_name, _number, widget.contactData.docId);

                  showToast('Contact Edited', context);
                  print('Contact Edited');
                  Navigator.pop(context);
                }
              }
            },
            label: Text(
              'Save',
              style: TextStyle(color: Colors.white),
            )));
  }
}
