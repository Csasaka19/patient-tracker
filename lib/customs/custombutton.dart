import 'package:flutter/material.dart';
import 'package:patient_tracker/configs/constants.dart';
import 'package:patient_tracker/customs/customtext.dart';


class customButton extends StatelessWidget {
  final Color labelColor;
  final String labelButton;
  const customButton({
    super.key,
    this.labelColor = primaryColor,
    this.labelButton = "Login",
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          print("Button Pressed");
        },
        child: customtitleText(label: labelButton, labelColor: labelColor),
        style: ElevatedButton.styleFrom(
          backgroundColor: secondaryColor,
          elevation: 10,
          padding: const EdgeInsets.all(30),
          shadowColor: blackColor,
          maximumSize: Size.fromWidth(200),
        ));
  }
}
