import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_tracker/widgets/common/help_support_button.dart';

class PageWrapper extends StatelessWidget {
  final Widget child;
  final bool showHelpButton;

  const PageWrapper({
    super.key,
    required this.child,
    this.showHelpButton = true,
  });

  @override
  Widget build(BuildContext context) {
    // Don't show help button on the help page itself
    if (!showHelpButton || Get.currentRoute == '/help_support') {
      return child;
    }

    return Stack(
      children: [
        child,
        const HelpSupportButton(),
      ],
    );
  }
}
