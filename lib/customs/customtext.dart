import 'package:flutter/material.dart';
import '/configs/constants.dart';

class CustomText extends StatelessWidget {
  final String label;
  final Color labelColor;
  final double fontSize;
  final bool italic;
  
  const CustomText(
       
      {Key? key, required this.label, this.labelColor = blackColor, this.fontSize = 16, this.italic = false,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style:  TextStyle(
          color: labelColor, fontSize: fontSize, fontWeight: FontWeight.bold, fontStyle: italic ? FontStyle.italic : FontStyle.normal,),
    );
  }
}