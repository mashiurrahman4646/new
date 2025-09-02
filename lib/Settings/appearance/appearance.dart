import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ThemeController.dart';


class AppearanceScreen extends StatelessWidget {
  const AppearanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(() => Scaffold(
      backgroundColor: themeController.isDarkModeActive
          ? const Color(0xFF121212)
          : const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: themeController.isDarkModeActive
            ? const Color(0xFF1E1E1E)
            : const Color(0xFFF8F9FA),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
              Icons.arrow_back_ios,
              color: themeController.isDarkModeActive ? Colors.white : Colors.black,
              size: 18
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'appearance'.tr,
          style: TextStyle(
            color: themeController.isDarkModeActive ? Colors.white : Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Light Theme Card
            _buildThemeCard(
              title: 'light_theme'.tr,
              icon: Icons.wb_sunny_outlined,
              isSelected: themeController.selectedTheme.value == 'Light' &&
                  !themeController.useSystemSettings.value,
              isLight: true,
              onTap: () {
                themeController.saveTheme('Light', false);
              },
              isDarkMode: themeController.isDarkModeActive,
            ),

            const SizedBox(height: 16),

            // Dark Theme Card
            _buildThemeCard(
              title: 'dark_theme'.tr,
              icon: Icons.nightlight_round,
              isSelected: themeController.selectedTheme.value == 'Dark' &&
                  !themeController.useSystemSettings.value,
              isLight: false,
              onTap: () {
                themeController.saveTheme('Dark', false);
              },
              isDarkMode: themeController.isDarkModeActive,
            ),

            const SizedBox(height: 24),

            // Use System Settings Toggle
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: themeController.isDarkModeActive ? const Color(0xFF1E1E1E) : Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'use_system_settings'.tr,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: themeController.isDarkModeActive ? Colors.white : Colors.black,
                        ),
                      ),
                      Switch.adaptive(
                        value: themeController.useSystemSettings.value,
                        onChanged: (value) {
                          themeController.saveTheme(
                              themeController.selectedTheme.value, value);
                        },
                        activeColor: const Color(0xFF007AFF),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'system_settings_desc'.tr,
                    style: TextStyle(
                      fontSize: 14,
                      color: themeController.isDarkModeActive ? Colors.grey[400] : const Color(0xFF8E8E93),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget _buildThemeCard({
    required String title,
    required IconData icon,
    required bool isSelected,
    required bool isLight,
    required VoidCallback onTap,
    required bool isDarkMode,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? Border.all(color: const Color(0xFF007AFF), width: 2)
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
                icon,
                size: 20,
                color: isDarkMode ? Colors.white : Colors.black
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isDarkMode ? Colors.white : Colors.black
              ),
            ),
            const Spacer(),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF007AFF)
                      : (isDarkMode ? const Color(0xFF555555) : const Color(0xFFD1D1D6)),
                  width: isSelected ? 6 : 2,
                ),
                color: isSelected ? const Color(0xFF007AFF) : Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}