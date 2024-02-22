import 'package:flutter/material.dart';
import 'package:patient_tracker/configs/constants.dart';
import 'package:patient_tracker/customs/customtext.dart';


class customButton extends StatelessWidget {
  final Color labelColor;
  final Color backgroundColor;
  final String labelButton;
  final Function()? onTap;

  const customButton({
    super.key,
    this.labelColor = primaryColor,
    this.backgroundColor = blackColor,
    this.labelButton = "Login",
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          print("Button Pressed");
        },

        child: customText(label: labelButton, labelColor: labelColor),
        
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          elevation: 20,
          padding: const EdgeInsets.all(25),
          shadowColor: blackColor,
          maximumSize: Size.fromWidth(600),

        ));
  }
}
