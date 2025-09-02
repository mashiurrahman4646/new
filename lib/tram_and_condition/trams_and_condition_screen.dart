import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_expense/tram_and_condition/trams_condition_controller.dart';
import '../Settings/appearance/ThemeController.dart';
import '../Settings/language/language_controller.dart';

import '../colors/app_colors.dart';
import '../text_styles.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final termsController = Get.put(TermsAndConditionsController());
    final languageController = Get.find<LanguageController>();

    return Obx(() {
      final isDark = themeController.isDarkMode.value;
      final selectedLanguage = languageController.selectedLanguage.value;

      // Get the T&C texts based on selected language
      final termsList = termsController.termsTexts[selectedLanguage] ?? termsController.termsTexts['English']!;

      // Get the intro text based on selected language
      final introText = termsController.introTexts[selectedLanguage] ?? termsController.introTexts['English']!;

      // Get the app bar title based on selected language
      final appBarTitle = termsController.appBarTitles[selectedLanguage] ?? termsController.appBarTitles['English']!;

      final bodyTextStyle = TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
        fontSize: 14,
        height: 1.3,
        color: isDark ? Colors.white : Colors.black,
      );

      final headingTextStyle = TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.w500,
        fontSize: 16,
        height: 1.2,
        color: isDark ? Colors.white : Colors.black,
      );

      return Scaffold(
        backgroundColor: isDark ? AppColors.darkBackground : Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Image.asset(
              'assets/icons/arrow-left.png',
              width: 24,
              height: 24,
              color: isDark ? Colors.white : Colors.black,
            ),
            onPressed: () => Get.back(),
          ),
          backgroundColor: isDark ? AppColors.darkBackground : Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            appBarTitle, // Now using translated title
            style: AppTextStyles.heading2.copyWith(color: isDark ? Colors.white : Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                introText,
                style: bodyTextStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ...termsList.map((item) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item['heading']!, style: headingTextStyle),
                    const SizedBox(height: 8),
                    Text(item['body']!, style: bodyTextStyle),
                    const SizedBox(height: 16),
                  ],
                );
              }).toList(),
            ],
          ),
        ),
      );
    });
  }
}