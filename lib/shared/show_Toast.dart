import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pim/shared/constants.dart';

showToast(String text, BuildContext context, {bool error = false}) {
  FToast fToast = FToast();
  fToast.init(context);

  Widget toast = Container(
    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0), color: Colors.black87),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.info_outline,
          color: error ? Colors.red : c2,
        ),
        SizedBox(
          width: 12.0,
        ),
        Text(
          text,
          style: TextStyle(color: Colors.white),
        )
      ],
    ),
  );

  fToast.showToast(
      child: toast,
      toastDuration: Duration(seconds: 2),
      gravity: ToastGravity.BOTTOM);
}
