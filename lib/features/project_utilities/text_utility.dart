import 'package:flutter/material.dart';
import 'package:wordy/features/project_utilities/colors_utility.dart';
import 'package:wordy/features/project_utilities/sizes_utility.dart';

class TextUtility extends StatelessWidget {
  const TextUtility({super.key, required this.txt, this.color, this.size});

  final String txt;
  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Text(txt,
        style: TextStyle(
          color: color ?? ColorsUtility.daintree,
          fontSize: size ?? SizesUtility.defaultSize,
          fontWeight: FontWeight.w500,
        ));
  }
}
