import 'package:flutter/material.dart';
import '/configs/constants.dart';

class customtitleText extends StatelessWidget {
  final String label;
  final Color labelColor;
  final double labelfontSize;
  const customtitleText(
      {super.key, required this.label, this.labelColor = appbartextColor, this.labelfontSize = 16});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style:  TextStyle(
          color: labelColor, fontSize: labelfontSize, fontWeight: FontWeight.bold),
    );
  }
}
