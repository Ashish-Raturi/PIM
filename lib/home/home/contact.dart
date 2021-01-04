import 'package:flutter/material.dart';
import 'package:pim/models/pim_user.dart';
import 'package:pim/shared/constants.dart';
import 'package:pim/shared/show_loading.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pim/home/home/thankpage.dart';
import 'package:pim/service/database/contact_us.dart';

class Contact extends StatefulWidget {
  final PimUserData user;

  const Contact({Key key, this.user}) : super(key: key);

  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  final _formkey = GlobalKey<FormState>();
  String _name;
  String _email;
  String _message;
  bool _showLoading = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return _showLoading
        ? ShowLoading()
        : Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
                child: SingleChildScrollView(
              child: Container(
                width: width,
                height: height,
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      width: double.infinity,
                      height: height / 2,
                      color: Colors.deepPurple,
                      child: Image.asset('assets/icons/contact_us.png',
                          fit: BoxFit.contain, width: 349.0, height: 249.0),
                    ),
                    Positioned(
                      bottom: 100.0,
                      left: 20.0,
                      right: 20.0,
                      child: SizedBox(
                        width: width - 40,
                        height: width - 40,
                        child: Card(
                          color: Colors.white,
                          elevation: 18.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Form(
                              key: _formkey,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                // mainAxisAlignment: MainAxisAlignment.center,
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  TextFormField(
                                    initialValue: widget.user.name,
                                    validator: (val) =>
                                        val.isEmpty ? 'Enter your name' : null,
                                    decoration: textInputDecoration3.copyWith(
                                      labelText: 'Name',
                                    ),
                                    onChanged: (val) {
                                      setState(() {
                                        _name = val;
                                      });
                                    },
                                  ),
                                  TextFormField(
                                    initialValue: widget.user.email,
                                    validator: (val) => val.isEmpty
                                        ? 'Enter your email address'
                                        : null,
                                    decoration: textInputDecoration3.copyWith(
                                      labelText: 'Email',
                                    ),
                                    onChanged: (val) {
                                      setState(() {
                                        _email = val;
                                      });
                                    },
                                  ),
                                  TextFormField(
                                    maxLines: 2,
                                    validator: (val) =>
                                        val.isEmpty ? 'Enter massage' : null,
                                    decoration: textInputDecoration3.copyWith(
                                      labelText: 'Message',
                                    ),
                                    onChanged: (val) {
                                      setState(() {
                                        _message = val;
                                      });
                                    },
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      //gmail
                                      GestureDetector(
                                        onTap: () async {
                                          const url =
                                              'mailto:ashishraturi368@gmail.com';
                                          // 'mailto:ashishraturi368@gmail.com?subject=Greetings&body=Hello%20World'
                                          if (await canLaunch(url)) {
                                            await launch(url);
                                          } else {
                                            throw 'Could not launch $url';
                                          }
                                        },
                                        child: Card(
                                          elevation: 9.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                          child: CircleAvatar(
                                            radius: 20.0,
                                            child: Image.asset(
                                              'assets/icons/gmail.png',
                                              fit: BoxFit.cover,
                                            ),
                                            backgroundColor: Colors.transparent,
                                          ),
                                        ),
                                      ),
                                      //instagram
                                      GestureDetector(
                                        onTap: () async {
                                          print('Instagarm');
                                          const url =
                                              'https://www.instagram.com/dark_wolf883?r=nametag';
                                          if (await canLaunch(url)) {
                                            await launch(url);
                                          } else {
                                            throw 'Could not launch $url';
                                          }
                                        },
                                        child: Card(
                                          elevation: 9.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                          child: CircleAvatar(
                                            radius: 20.0,
                                            child: Image.asset(
                                              'assets/icons/instagram.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      //twitter
                                      GestureDetector(
                                        onTap: () async {
                                          print('Instagarm');
                                          const url =
                                              'https://twitter.com/AshishRaturi0?s=03';
                                          if (await canLaunch(url)) {
                                            await launch(url);
                                          } else {
                                            throw 'Could not launch $url';
                                          }
                                        },
                                        child: Card(
                                          elevation: 9.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                          child: CircleAvatar(
                                            radius: 20.0,
                                            child: Image.asset(
                                              'assets/icons/twitter.jpg',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
            // floatingActionButtonLocation:
            //     FloatingActionButtonLocation.miniCenterFloat,
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.deepPurple,
              child: Image.asset(
                'assets/icons/Send_Icon.png',
                fit: BoxFit.cover,
                height: 22.0,
                width: 22.0,
                color: Colors.white,
              ),
              onPressed: () async {
                if (_formkey.currentState.validate()) {
                  setState(() {
                    _showLoading = true;
                  });
                  var docId = await ContactUsDbService().addUserData(
                      _name ?? widget.user.name,
                      _email ?? widget.user.email,
                      _message);
                  if (docId != null) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ThankPage()));
                    setState(() {
                      _showLoading = false;
                    });
                    print('Message Send');
                  } else {
                    setState(() {
                      _showLoading = false;
                    });
                  }
                }
              },
            ));
  }
}
