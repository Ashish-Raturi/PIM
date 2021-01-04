import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pim/service/auth.dart';
import 'package:pim/shared/constants.dart';
import 'package:pim/shared/show_Toast.dart';
import 'package:pim/shared/show_loading.dart';
import 'package:snappable/snappable.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();
  final _formkey = GlobalKey<FormState>();
  String _mailId;
  String _password;
  bool showLoading = false;
  bool _pwVisible = false;

  @override
  Widget build(BuildContext context) {
    return showLoading
        ? ShowLoading()
        : Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 40.0),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          Text(
                            'Welcome Back!',
                            style: TextStyle(
                                fontSize: 26.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0,
                                wordSpacing: 1.0,
                                color: c2),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            'Login to continue',
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 2.0,
                                wordSpacing: 1.0,
                                color: c2),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Snappable(
                            snapOnTap: true,
                            child: Container(
                              alignment: Alignment.center,
                              child: Image(
                                image:
                                    AssetImage('assets/icons/LogIn_Vector.png'),
                                fit: BoxFit.contain,
                                height: 220.0,
                                width: 140.0,
                                // fit: Boxfit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          SizedBox(
                            width: 300.0,
                            child: TextFormField(
                              decoration: textInputDecoration2.copyWith(
                                hintText: 'Mail Id',
                                prefixIcon: Icon(Icons.mail_outline, color: c2),
                              ),
                              validator: (val) => val.isEmpty
                                  ? 'Please enter a email id'
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
                              validator: (val) => val.length <= 6
                                  ? 'Please enter 6+ char password'
                                  : null,
                              onChanged: (val) =>
                                  setState(() => _password = val),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          SizedBox(
                            width: 260.0,
                            // height: 50.0,
                            child: RaisedButton(
                              color: c2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0)),
                              child: Text(
                                'LOGIN',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600,
                                    wordSpacing: 1.0,
                                    letterSpacing: 1.0),
                              ),
                              onPressed: () async {
                                if (_formkey.currentState.validate()) {
                                  setState(() => showLoading = true);
                                  dynamic result = await _authService
                                      .signInWithEmailAndPassword(
                                          _mailId, _password);

                                  if (result == null) {
                                    setState(() {
                                      showLoading = false;
                                      showToast(
                                          'Can\'t signin with those credentials',
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
                            text: 'First time here ? ',
                            style: TextStyle(
                              color: c3,
                            ),
                            children: [
                              TextSpan(
                                  text: 'Sign up.',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      color: c2,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      print('SignUp');
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
