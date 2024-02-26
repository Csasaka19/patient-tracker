import 'package:flutter/material.dart';
import 'package:patient_tracker/configs/constants.dart';
import 'package:patient_tracker/customs/customtext.dart';

class MyTile extends StatelessWidget {
  final String randomText ;
  const MyTile({Key? key, this.randomText = "",}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 78,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: secondaryColor,
          ),
          child: Center(
            child: customText(label: randomText, fontSize: 13, italic: true,),
          ),
        ),
      ),
    );
  }
}
