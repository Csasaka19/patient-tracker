import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:patient_tracker/configs/constants.dart';
import 'package:patient_tracker/customs/custombutton.dart';
import 'package:patient_tracker/customs/customtext.dart';
import 'package:patient_tracker/customs/customtextfield.dart';
import 'package:patient_tracker/customs/square_tile.dart';
import 'package:patient_tracker/utils/prefs.dart';
import 'package:patient_tracker/core/theme/app_theme.dart';
import 'package:patient_tracker/widgets/common/app_logo.dart';
import 'package:patient_tracker/widgets/common/theme_switch.dart';

TextEditingController userNameController = TextEditingController();
TextEditingController passwordController = TextEditingController();

Prefs myprefs = Prefs();

class Login extends StatelessWidget {
  const Login({super.key});

  void loginButtonPressed() {}

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDarkMode
                ? [AppTheme.darkBlue, const Color(0xFF121212)]
                : [AppTheme.accentBlue.withOpacity(0.8), AppTheme.primaryBlue],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
              child: Column(
                children: [
                // Theme toggle and brand logo
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 16.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const ThemeSwitchIcon(size: 22),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // App logo
                const AppLogo(
                  size: 100,
                  darkMode: true,
                ),

                const SizedBox(height: 50),

                // Login form
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? Colors.grey.shade900.withOpacity(0.8)
                        : Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome back',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Login to your account',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                  const SizedBox(height: 30),
            
                      // Username field
                      TextField(
                        controller: userNameController,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          prefixIcon: const Icon(Icons.person_outline),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Password field
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock_outline),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Forgot password
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            // Show password recovery dialog
                            Get.snackbar(
                              'Password Recovery',
                              'Password recovery feature will be implemented soon',
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: isDarkMode
                                  ? AppTheme.accentBlue
                                  : AppTheme.primaryBlue,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Login button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            // Skip authentication and go directly to home
                            Get.offAllNamed('/home');
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'LOGIN',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ),
                        ),
                      ],
                    ),
                  ),
            
                const SizedBox(height: 30),

                // Social login options
                Text(
                  'Or continue with',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 20),

                // Social login buttons
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    _socialLoginButton(
                      context,
                      'assets/images/google.png',
                      isDarkMode,
                    ),
                    const SizedBox(width: 20),
                    _socialLoginButton(
                      context,
                      'assets/logos/healthy.png',
                      isDarkMode,
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // Register link
                Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Text(
                      'Don\'t have an account? ',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed('/registration');
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(
                          color: isDarkMode
                              ? AppTheme.accentGreen
                              : AppTheme.secondaryGreen,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _socialLoginButton(
      BuildContext context, String assetPath, bool isDarkMode) {
    return InkWell(
      onTap: () {
        Get.snackbar(
          'Social Login',
          'Social login feature will be implemented soon',
          snackPosition: SnackPosition.BOTTOM,
        );
      },
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey.shade800 : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset(assetPath),
        ),
      ),
    );
  }
}
