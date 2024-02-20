import 'package:flutter/material.dart';

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

    return Container(
      width: MediaQuery.of(context).size.width / 2,
      child: TextField(
        focusNode: focusNode,
        obscureText: hideText,
        cursorRadius: Radius.elliptical(5, 0),
        controller: userFieldController,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: isFocused ? Colors.blue : Colors.grey,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Color.fromARGB(255, 33, 72, 243),
            ),
          ),
          suffixIcon: isPassword ? const Icon(Icons.visibility) : null,
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }
}
