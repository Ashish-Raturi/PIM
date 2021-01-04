import 'package:flutter/material.dart';
import 'package:pim/shared/constants.dart';

class ThankPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: SafeArea(
          child: Stack(children: [
        Positioned(
          right: 10.0,
          top: 10.0,
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Image.asset(
              'assets/icons/cross.png',
              fit: BoxFit.cover,
              height: 20.0,
              color: Colors.white,
              width: 20.0,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Thank You.',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 80.0,
                    letterSpacing: 1.0,
                    wordSpacing: 1.0,
                    fontWeight: FontWeight.bold),
              ),
              Divider(
                color: Colors.deepPurple[900],
                thickness: 2.0,
              ),
              Text(
                'We\'ll be in touch. \nShortly',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    letterSpacing: 1.0,
                    wordSpacing: 1.0,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ])),
    );
  }
}
