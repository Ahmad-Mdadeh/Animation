import 'package:flutter/material.dart';

class TextUtils extends StatelessWidget {
  final String text;
  final Color color;
  final Color? backgroundColor;
  final FontWeight fontWeight;
  final double fontSize;
  final TextDecoration? textDecoration;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;
  final double? height;

  const TextUtils({super.key,
    required this.text,
    required this.color,
    required this.fontWeight,
    required this.fontSize,
    this.textDecoration,
    this.textAlign,
    this.textOverflow,
    this.height,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      textAlign: textAlign,
      style: TextStyle(
        backgroundColor: backgroundColor,
        height: height,
        color: color,
        fontSize: fontSize,
        overflow: textOverflow,
        fontWeight: fontWeight,
        decoration: textDecoration,
      ),
    );
  }
}
