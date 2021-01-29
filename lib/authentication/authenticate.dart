import 'package:flutter/material.dart';

import 'package:unitrade_website/screens/home.dart';
import 'package:unitrade_website/shared/string.dart';

class Authentication extends StatelessWidget {
  final String userId;
  Authentication({this.userId});
  @override
  Widget build(BuildContext context) {
  
    return MyHomePage(uid: userId, title: HOME_TITLE,);
  }
}