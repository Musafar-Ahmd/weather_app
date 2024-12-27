import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class CommonFlushBar {
  static showFlushbar(
      {required context,
      required Color color,
      required IconData icon,
      required String message}) {
    return Flushbar(
      backgroundColor: color,
      borderRadius: BorderRadius.circular(15),
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 100),
      message: message,
      icon: Icon(
        icon,
        size: 28.0,
        color: Colors.white,
      ),
      duration: Duration(seconds: 3),
    )..show(context);
  }
}
