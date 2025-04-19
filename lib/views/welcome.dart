import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:patient_tracker/core/theme/app_theme.dart';
import 'package:patient_tracker/widgets/common/app_logo.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  _WelcomeViewState createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _slideAnimation;
  final GetStorage storage = GetStorage();
  bool seenOnboarding = false;

  @override
  void initState() {
    super.initState();

    // Set up animations
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 3500),
      vsync: this,
    );

    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.65, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    // Check if user has seen onboarding
    seenOnboarding = storage.read('seenOnboarding') ?? false;

    // Start animation
    _animationController.forward();

    // Navigate after delay
    Future.delayed(const Duration(seconds: 8), () {
      if (seenOnboarding) {
        Get.toNamed('/login');
      } else {
        storage.write('seenOnboarding', true);
        Get.toNamed('/onboarding');
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDarkMode
                ? [const Color(0xFF0D47A1), const Color(0xFF1A237E)]
                : [const Color(0xFF42A5F5), const Color(0xFF1E88E5)],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated logo
            FadeTransition(
              opacity: _fadeInAnimation,
              child: const AppLogo(
                size: 120,
                darkMode: true,
                showText: false,
              ),
            ),
            const SizedBox(height: 24),

            // Animated text
            FadeTransition(
              opacity: _fadeInAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: const Column(
                  children: [
                    Text(
                      "Afya Yangu",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.5,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Your Health Companion",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
