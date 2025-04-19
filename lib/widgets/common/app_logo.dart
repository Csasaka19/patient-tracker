import 'package:flutter/material.dart';
import 'package:patient_tracker/core/theme/app_theme.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final bool darkMode;
  final bool showText;

  const AppLogo({
    Key? key,
    this.size = 50.0,
    this.darkMode = false,
    this.showText = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color primaryColor =
        darkMode ? AppTheme.accentBlue : AppTheme.primaryBlue;
    final Color secondaryColor =
        darkMode ? AppTheme.accentGreen : AppTheme.secondaryGreen;
    final Color textColor = darkMode ? AppTheme.white : AppTheme.black;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Logo icon
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: AppTheme.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Stack(
            children: [
              Center(
                child: Icon(
                  Icons.favorite,
                  color: primaryColor,
                  size: size * 0.5,
                ),
              ),
              Center(
                child: Icon(
                  Icons.local_hospital,
                  color: secondaryColor,
                  size: size * 0.3,
                ),
              ),
            ],
          ),
        ),
        if (showText) ...[
          const SizedBox(height: 8),
          Text(
            "Afya Yangu",
            style: TextStyle(
              fontSize: size * 0.36,
              fontWeight: FontWeight.bold,
              color: textColor,
              letterSpacing: 0.5,
            ),
          ),
          Text(
            "Your Health Companion",
            style: TextStyle(
              fontSize: size * 0.16,
              fontWeight: FontWeight.w400,
              color: textColor.withOpacity(0.7),
              letterSpacing: 0.5,
            ),
          ),
        ],
      ],
    );
  }
}
