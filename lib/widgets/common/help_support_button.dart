import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpSupportButton extends StatelessWidget {
  const HelpSupportButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 16,
      right: 16,
      child: FloatingActionButton(
        heroTag: 'helpButton',
        mini: true,
        onPressed: () {
          Get.toNamed('/help_support');
        },
        tooltip: 'Help & Support',
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: const Icon(
          Icons.help_outline,
          color: Colors.white,
        ),
      ),
    );
  }
}
