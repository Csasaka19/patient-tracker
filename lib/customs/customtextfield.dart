import 'package:flutter/material.dart';
import 'package:patient_tracker/configs/constants.dart';

class CustomTextField extends StatefulWidget {
  final IconData? icon;
  final bool isPassword;
  final String? hint;
  final Color textColor;

  const CustomTextField({
    Key? key,
    required this.userFieldController,
    this.icon,
    this.isPassword = false,
    this.hint,
    this.textColor = appbartextColor,
  });
  final TextEditingController userFieldController;

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool hideText = true;

  @override
  Widget build(BuildContext context) {
    final FocusNode focusNode = FocusNode();
    bool isFocused = focusNode.hasFocus;

    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: TextField(
        focusNode: focusNode,
        obscureText: widget.isPassword ? hideText : false,
        cursorRadius: const Radius.elliptical(5, 0),
        controller: widget.userFieldController,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: TextStyle(color: appbartextColor),
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: isFocused ? primaryColor : appbartextColor,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: primaryColor,
            ),
          ),
          suffixIcon: widget.isPassword
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      hideText = !hideText;
                    });
                  },
                  child: Icon(
                    hideText ? Icons.visibility_off : Icons.visibility,
                    color: appbartextColor,
                  ),
                )
              : null,
          prefixIcon: Icon(
            widget.icon,
            color: appbartextColor,
          ),
        ),
      ),
    );
  }
}
