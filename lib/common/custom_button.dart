import 'dart:ui';

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double height;
  final double width;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;
  final double borderRadius;
  final FontWeight fontWeight;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.height = 45,
    this.width = double.infinity,
    this.backgroundColor = Colors.green,
    this.textColor = Colors.white,
    this.fontSize = 16,
    this.borderRadius = 45,
    this.fontWeight = FontWeight.w400
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: backgroundColor,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: fontSize,
              fontWeight: fontWeight,
            ),
          ),
        ),
      ),
    );
  }
}
