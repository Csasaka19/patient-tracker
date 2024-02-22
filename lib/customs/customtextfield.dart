import 'package:flutter/material.dart';
import 'package:patient_tracker/configs/constants.dart';

class customTextField extends StatelessWidget {
  final IconData? icon;
  final bool hideText;
  final bool isPassword;
  final String? hint;
  
  const customTextField({
    super.key,
    required this.userFieldController,
    this.icon,
    this.hideText = false,
    this.isPassword = false,
    this.hint,
  });

  final TextEditingController userFieldController;

  @override
  Widget build(BuildContext context) {
    final FocusNode focusNode = FocusNode();
    bool isFocused = focusNode.hasFocus;

    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: TextField(
        focusNode: focusNode,
        obscureText: hideText,
        cursorRadius: const Radius.elliptical(5, 0),
        controller: userFieldController,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: isFocused ? primaryColor : blackColor,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: primaryColor,
            ),
          ),
          suffixIcon: isPassword ? const Icon(Icons.visibility) : null,
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }
}
