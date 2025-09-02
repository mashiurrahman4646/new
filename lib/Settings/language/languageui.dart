import 'package:flutter/material.dart';
import 'package:get/get.dart';
 // Import your ThemeController
import '../appearance/ThemeController.dart';
import 'language_controller.dart';

class LanguageSettingsScreen extends StatelessWidget {
  const LanguageSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LanguageController languageController = Get.put(LanguageController());
    final themeController = Get.find<ThemeController>();

    return Obx(() => Scaffold(
      backgroundColor: themeController.isDarkModeActive
          ? const Color(0xFF121212)
          : const Color(0xFFF2F2F7),
      appBar: AppBar(
        backgroundColor: themeController.isDarkModeActive
            ? const Color(0xFF1E1E1E)
            : const Color(0xFFF2F2F7),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
              Icons.arrow_back_ios,
              color: themeController.isDarkModeActive ? Colors.white : Colors.black,
              size: 16
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'language_settings'.tr,
          style: TextStyle(
            color: themeController.isDarkModeActive ? Colors.white : Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'language_settings_desc'.tr,
              style: TextStyle(
                  fontSize: 14,
                  color: themeController.isDarkModeActive ? Colors.grey[400] : const Color(0xFF8E8E93),
                  height: 1.4
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: themeController.isDarkModeActive ? const Color(0xFF1E1E1E) : Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  for (int i = 0; i < languageController.languages.length; i++) ...[
                    _buildLanguageOption(
                      languageController.languages[i],
                      languageController.selectedLanguage.value ==
                          languageController.languages[i],
                          () {
                        languageController.changeLanguage(languageController.languages[i]);
                      },
                      isDarkMode: themeController.isDarkModeActive,
                    ),
                    if (i < languageController.languages.length - 1)
                      Container(
                        height: 0.5,
                        color: themeController.isDarkModeActive
                            ? const Color(0xFF333333)
                            : const Color(0xFFE5E5EA),
                        margin: const EdgeInsets.only(left: 16),
                      ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: themeController.isDarkModeActive
                  ? const Color(0xFF332900)
                  : const Color(0xFFFFF2CC),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                    Icons.warning_amber,
                    color: themeController.isDarkModeActive
                        ? const Color(0xFFFFB300)
                        : const Color(0xFFFF9500),
                    size: 16
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'language_warning'.tr,
                    style: TextStyle(
                        fontSize: 12,
                        color: themeController.isDarkModeActive
                            ? const Color(0xFFFFB300)
                            : const Color(0xFF8E6914),
                        height: 1.3
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Get.back();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF007AFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
              ),
              child: Text(
                'apply_changes'.tr,
                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(height: 34),
        ],
      ),
    ));
  }

  Widget _buildLanguageOption(String language, bool isSelected, VoidCallback onTap, {required bool isDarkMode}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Text(
              language,
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: isDarkMode ? Colors.white : Colors.black
              ),
            ),
            const Spacer(),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? const Color(0xFF007AFF) : Colors.transparent,
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF007AFF)
                      : (isDarkMode ? const Color(0xFF555555) : const Color(0xFFD1D1D6)),
                  width: isSelected ? 6 : 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}