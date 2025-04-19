import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  final _isDarkMode = false.obs;
  final String _themeKey = 'isDarkMode';

  bool get isDarkMode => _isDarkMode.value;

  @override
  void onInit() {
    super.onInit();
    _loadThemeFromPrefs();
  }

  Future<void> _loadThemeFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final savedMode = prefs.getBool(_themeKey);
    if (savedMode != null) {
      _isDarkMode.value = savedMode;
      _applyTheme();
    }
  }

  Future<void> toggleTheme() async {
    _isDarkMode.value = !_isDarkMode.value;
    _applyTheme();

    // Save preference
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, _isDarkMode.value);
  }

  void _applyTheme() {
    Get.changeThemeMode(_isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }
}
