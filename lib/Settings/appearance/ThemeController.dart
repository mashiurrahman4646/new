import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController with WidgetsBindingObserver {
  // Constants for storage keys
  static const String _themeKey = "app_theme";
  static const String _systemKey = "system_theme";

  // Reactive theme variables
  final RxString selectedTheme = 'Light'.obs;
  final RxBool useSystemSettings = true.obs;
  final RxBool isDarkMode = false.obs;

  // Theme mode names for UI
  static const List<String> themeOptions = ['Light', 'Dark', 'System'];

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    loadTheme();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangePlatformBrightness() {
    if (useSystemSettings.value) {
      _updateDarkMode();
      Get.forceAppUpdate(); // Force UI to update
    }
  }

  /// Computes the current ThemeMode based on settings
  ThemeMode get themeMode {
    if (useSystemSettings.value) return ThemeMode.system;
    return selectedTheme.value == 'Dark' ? ThemeMode.dark : ThemeMode.light;
  }

  /// Loads theme preferences from SharedPreferences
  Future<void> loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      selectedTheme.value = prefs.getString(_themeKey) ?? 'Light';
      useSystemSettings.value = prefs.getBool(_systemKey) ?? true;
      _updateDarkMode();
    } catch (e) {
      // Fallback to default values if loading fails
      selectedTheme.value = 'Light';
      useSystemSettings.value = true;
      _updateDarkMode();
    }
  }

  /// Saves theme preferences and updates the app theme
  Future<void> saveTheme(String theme, bool system) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await Future.wait([
        prefs.setString(_themeKey, theme),
        prefs.setBool(_systemKey, system),
      ]);

      selectedTheme.value = theme;
      useSystemSettings.value = system;
      _updateDarkMode();

      // Force theme update across the app
      Get.changeThemeMode(themeMode);
      Get.forceAppUpdate();
    } catch (e) {
      Get.snackbar('Error', 'Failed to save theme settings');
    }
  }

  /// Toggles between light/dark theme when system theme is disabled
  Future<void> toggleTheme() async {
    if (!useSystemSettings.value) {
      final newTheme = selectedTheme.value == 'Light' ? 'Dark' : 'Light';
      await saveTheme(newTheme, false);
    }
  }

  /// Updates the dark mode status based on current settings
  void _updateDarkMode() {
    isDarkMode.value = useSystemSettings.value
        ? WidgetsBinding.instance.window.platformBrightness == Brightness.dark
        : selectedTheme.value == 'Dark';
  }

  /// Helper to check if dark mode is currently active
  bool get isDarkModeActive => isDarkMode.value;
}