import 'package:flutter/material.dart';

class TextUtility extends StatelessWidget {
  const TextUtility(
      {super.key, required this.txt, required this.color, required this.size});

  final String txt;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Text(txt,
        style: TextStyle(
          color: color,
          fontSize: size,
          fontWeight: FontWeight.w500,
        ));
  }
}
