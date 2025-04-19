import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_tracker/core/controllers/theme_controller.dart';
import 'package:patient_tracker/core/theme/app_theme.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return Obx(
      () => Switch(
        value: themeController.isDarkMode,
        onChanged: (_) => themeController.toggleTheme(),
        activeColor: AppTheme.accentBlue,
        activeTrackColor: AppTheme.accentBlue.withOpacity(0.5),
        inactiveThumbColor: AppTheme.primaryBlue,
        inactiveTrackColor: AppTheme.grey.withOpacity(0.5),
      ),
    );
  }
}

class ThemeSwitchIcon extends StatelessWidget {
  final double size;

  const ThemeSwitchIcon({
    Key? key,
    this.size = 24.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return InkWell(
      onTap: () => themeController.toggleTheme(),
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey.shade800
              : Colors.grey.shade200,
        ),
        child: Obx(
          () => Icon(
            themeController.isDarkMode
                ? Icons.light_mode_rounded
                : Icons.dark_mode_rounded,
            size: size,
            color: themeController.isDarkMode
                ? AppTheme.accentBlue
                : AppTheme.primaryBlue,
          ),
        ),
      ),
    );
  }
}
