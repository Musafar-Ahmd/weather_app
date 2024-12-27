import 'package:flutter/material.dart';

InputDecoration inputDecorationWithBorder({
  Widget? suffixIcon,
  Icon? prefixIcon,
  bool isDense = false,
  required Color color,
  String? hintText,
}) {
  return InputDecoration(
    hintStyle: TextStyle(color: Colors.black),
    hintText: hintText,
    border: OutlineInputBorder(
        borderSide: BorderSide(color: color, width: 1.0),
        borderRadius: BorderRadius.circular(8)),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: color, width: 1.0),
        borderRadius: BorderRadius.circular(8)),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: color, width: 1.0),
        borderRadius: BorderRadius.circular(8)),
    suffixIcon: suffixIcon,
    prefixIcon: prefixIcon,

    isDense: isDense, // Controls the vertical height of the input
  );
}
