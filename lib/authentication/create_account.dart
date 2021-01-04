import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pim/service/auth.dart';
import 'package:pim/shared/constants.dart';
import 'package:pim/shared/show_Toast.dart';
import 'package:pim/shared/show_loading.dart';
import 'package:snappable/snappable.dart';

class CreateAccount extends StatefulWidget {
  final Function toggleView;
  CreateAccount({this.toggleView});
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final AuthService _authService = AuthService();
  final _formkey = GlobalKey<FormState>();
  String _mailId;
  String _fullName;
  String _password;
  bool showloading = false;
  bool _pwVisible = false;

  @override
  Widget build(BuildContext context) {
    return showloading
        ? ShowLoading()
        : Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(vertical: 40.0),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Create Account',
                            style: TextStyle(
                                fontSize: 27.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0,
                                wordSpacing: 1.0,
                                color: c2),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Snappable(
                            snapOnTap: true,
                            child: Container(
                              alignment: Alignment.center,
                              child: Image(
                                image: AssetImage(
                                    'assets/icons/SignUp_Vector.png'),
                                height: 150.0,
                                width: 280.0,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          SizedBox(
                            width: 300.0,
                            child: TextFormField(
                              decoration: textInputDecoration2.copyWith(
                                hintText: 'Mail ID',
                                prefixIcon: Icon(Icons.mail_outline, color: c2),
                              ),
                              validator: (val) => val.isEmpty
                                  ? 'Please enter your email id'
                                  : null,
                              onChanged: (val) => setState(() => _mailId = val),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          SizedBox(
                            width: 300.0,
                            child: TextFormField(
                              decoration: textInputDecoration2.copyWith(
                                hintText: 'Username',
                                prefixIcon: Icon(Icons.person, color: c2),
                              ),
                              validator: (val) => val.isEmpty
                                  ? 'Please enter your full name'
                                  : null,
                              onChanged: (val) =>
                                  setState(() => _fullName = val),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          SizedBox(
                            width: 300.0,
                            child: TextFormField(
                              obscureText: !_pwVisible,
                              decoration: textInputDecoration2.copyWith(
                                hintText: 'Password',
                                prefixIcon:
                                    Icon(Icons.lock_outline_rounded, color: c2),
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
                                      color: c3),
                                ),
                              ),
                              validator: (val) => val.length < 6
                                  ? 'Please enter 6+ char password'
                                  : null,
                              onChanged: (val) =>
                                  setState(() => _password = val),
                            ),
                          ),
                          SizedBox(
                            height: 28.0,
                          ),
                          SizedBox(
                            width: 260.0,
                            // height: 50.0,
                            child: RaisedButton(
                              color: c2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0)),
                              child: Text(
                                'Create',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600,
                                    wordSpacing: 1.0,
                                    letterSpacing: 1.0),
                              ),
                              onPressed: () async {
                                if (_formkey.currentState.validate()) {
                                  setState(() {
                                    showloading = true;
                                  });
                                  dynamic result = await _authService
                                      .createAccountWithEmailAndPasword(
                                          _mailId, _password, _fullName);
                                  if (result == null) {
                                    setState(() {
                                      showloading = false;
                                      showToast(
                                          'Unauthorized. Please check the email address and password and try again',
                                          context,
                                          error: true);
                                    });
                                  }
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          RichText(
                              text: TextSpan(
                            text: 'Not the first time here ? ',
                            style: TextStyle(
                              color: c3,
                            ),
                            children: [
                              TextSpan(
                                  text: 'Log in.',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      color: c2,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      widget.toggleView();
                                    }),
                            ],
                          ))
                        ],
                      ),
                    )),
              ),
            ),
          );
  }
}
