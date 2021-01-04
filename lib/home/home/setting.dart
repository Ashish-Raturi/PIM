import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pim/models/pim_user.dart';
import 'package:pim/service/database/user_data.dart';
import 'package:pim/shared/constants.dart';
import 'package:pim/shared/show_loading.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  final PimUserData _pimUserData;
  SettingPage(this._pimUserData);
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final _formkey = GlobalKey<FormState>();
  bool _editData = false;
  bool _loading = false;
  bool _pwVisible = false;
  String _name;
  String _email;
  String _mobile;
  String _password;
  String _location;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<PimUser>(context);
    return _loading
        ? ShowLoading(
            color: gold,
            bcolor: c5,
          )
        : Scaffold(
            backgroundColor: c5,
            body: SafeArea(
                child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Center(
                  // padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Card(
                              child: CircleAvatar(
                                backgroundColor: c4,
                                radius: 80.0,
                              ),
                              shape: CircleBorder(),
                              elevation: 18.0,
                            ),
                            CircleAvatar(
                              backgroundColor: c1,
                              child: Text(
                                widget._pimUserData.name
                                    .substring(0, 1)
                                    .toUpperCase(),
                                style: TextStyle(
                                    color: c5,
                                    fontSize: 70.0,
                                    fontWeight: FontWeight.w500),
                              ),
                              radius: 70.0,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 80.0, vertical: 10.0),
                          child: TextFormField(
                              textAlign: TextAlign.center,
                              enabled: _editData,
                              initialValue:
                                  widget._pimUserData.name.toUpperCase(),
                              style: TextStyle(color: Colors.white),
                              validator: (val) =>
                                  val.isEmpty ? 'Enter your name' : null,
                              decoration: textInputDecoration2,
                              onChanged: (value) => setState(() {
                                    _name = value;
                                  })),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 80.0, vertical: 10.0),
                          child: TextFormField(
                              enabled: false,
                              textAlign: TextAlign.center,
                              initialValue: widget._pimUserData.email,
                              style: TextStyle(color: Colors.white),
                              decoration: textInputDecoration2,
                              validator: (val) => val.isEmpty
                                  ? 'Enter a vaild email address'
                                  : null,
                              onChanged: (value) => setState(() {
                                    _email = value;
                                  })),
                        ),
                        SizedBox(height: 10.0),
                        Divider(
                          color: c3,
                          thickness: 2.0,
                        ),
                        SizedBox(height: 10.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 28.0, vertical: 10.0),
                          child: TextFormField(
                              initialValue:
                                  _mobile ?? widget._pimUserData.mobile,
                              enabled: _editData,
                              style: TextStyle(color: Colors.white),
                              validator: (val) =>
                                  val.length != 10 || _mobile == null
                                      ? 'Enter 10 digit mobile nuber'
                                      : null,
                              decoration: textInputDecoration2.copyWith(
                                  prefixIcon: Icon(Icons.phone, color: c4),
                                  hintText: 'Mobile',
                                  hintStyle: TextStyle(color: c4)),
                              onChanged: (value) => setState(() {
                                    _mobile = value;
                                  })),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 28.0, vertical: 10.0),
                          child: TextFormField(
                              initialValue: widget._pimUserData.password,
                              enabled: false,
                              obscureText: !_pwVisible,
                              style: TextStyle(color: Colors.white),
                              validator: (val) => val.length <= 6
                                  ? 'Enter 6+ char password'
                                  : null,
                              decoration: textInputDecoration2.copyWith(
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _pwVisible = !_pwVisible;
                                    });
                                  },
                                  child: Icon(
                                      _pwVisible
                                          ? FontAwesomeIcons.eyeSlash
                                          : FontAwesomeIcons.eye,
                                      color: c4),
                                ),
                                prefixIcon:
                                    Icon(Icons.lock_outline_rounded, color: c4),
                              ),
                              onChanged: (value) => setState(() {
                                    _password = value;
                                  })),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 28.0, vertical: 10.0),
                          child: TextFormField(
                              initialValue: widget._pimUserData.location,
                              style: TextStyle(color: Colors.white),
                              enabled: _editData,
                              validator: (val) =>
                                  val.isEmpty || _location == null
                                      ? 'Enter your addrress'
                                      : null,
                              decoration: textInputDecoration2.copyWith(
                                hintText: 'Address',
                                hintStyle: TextStyle(color: c4),
                                prefixIcon: Icon(Icons.location_on, color: c4),
                              ),
                              onChanged: (value) => setState(() {
                                    _location = value;
                                  })),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )),
            floatingActionButton: FloatingActionButton.extended(
                backgroundColor: c4,
                onPressed: () async {
                  if (!_editData) {
                    //edit
                    setState(() {
                      _editData = true;
                    });
                  } else if (_name == null &&
                      _mobile == null &&
                      _location == null) {
                    setState(() {
                      _editData = false;
                    });
                  } else {
                    if (_formkey.currentState.validate()) {
                      print('Save');
                      setState(() {
                        _loading = true;
                      });
                      await UserDbService(uid: user.uid)
                          .addUserData(
                              _email ?? widget._pimUserData.email,
                              _name ?? widget._pimUserData.name,
                              _password ?? widget._pimUserData.password,
                              _mobile ?? widget._pimUserData.mobile,
                              _location ?? widget._pimUserData.location)
                          .whenComplete(() => setState(() {
                                _editData = false;
                                _loading = false;
                              }));
                    }
                  }
                },
                icon: Icon(
                  _editData == true ? Icons.save : Icons.edit,
                  color: c5,
                ),
                label: Text(_editData == true ? 'Save' : 'Edit',
                    style: TextStyle(color: c5))));
  }
}
