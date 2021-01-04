import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pim/shared/constants.dart';

class ShowLoading extends StatelessWidget {
  final Color color;
  final Color bcolor;
  ShowLoading({this.color = c2, this.bcolor = c4});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bcolor,
      body: SpinKitDoubleBounce(
        color: color,
      ),
    );
  }
}
