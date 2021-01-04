import 'package:flutter/material.dart';
import 'package:pim/authentication/auth.dart';
import 'package:pim/home/home/home.dart';
import 'package:pim/models/pim_user.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<PimUser>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
