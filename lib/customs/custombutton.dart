import 'package:flutter/material.dart';
import 'package:patient_tracker/configs/constants.dart';
import 'package:patient_tracker/customs/customtext.dart';


class customButton extends StatelessWidget {
  final Color labelColor;
  final Color backgroundColor;
  final String labelButton;
  final VoidCallback? action;

  const customButton({
    super.key,
    this.labelColor = primaryColor,
    this.backgroundColor = secondaryColor,
    this.labelButton = "Login",
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: action,
        
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          elevation: 20,
          padding: const EdgeInsets.all(25),
          shadowColor: blackColor,
          maximumSize: const Size.fromWidth(600),

        ),
        child: CustomText(label: labelButton, labelColor: labelColor,));
  }
}
