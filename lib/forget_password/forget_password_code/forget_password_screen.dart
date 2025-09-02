import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_expense/colors/app_colors.dart';
import 'package:your_expense/routes/app_routes.dart';
import 'package:your_expense/text_styles.dart';

import '../../Settings/appearance/ThemeController.dart';

class ForgotPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 375;
    final isDarkMode = themeController.isDarkMode.value;

    return Scaffold(
      backgroundColor: isDarkMode ? AppColors.darkBackground : Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isSmallScreen ? 16 : 24,
            vertical: 16,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // App bar with back button and title
                Row(
                  children: [
                    IconButton(
                      icon: Image.asset(
                        'assets/icons/arrow-left.png',
                        color: isDarkMode ? Colors.white : null,
                      ),
                      onPressed: () => Get.back(),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 40),
                          child: Text(
                            'forget_password'.tr,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              fontSize: isSmallScreen ? 20 : 22,
                              color: isDarkMode ? Colors.white : AppColors.text800,
                              height: 1.2,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: isSmallScreen ? 24 : 40),

                // Centered Lock Icon with title below it
                Center(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/lock_.png',
                        width: isSmallScreen ? 64 : 80,
                        height: isSmallScreen ? 64 : 80,

                      ),
                      const SizedBox(height: 16),
                      Text(
                        'forget_password'.tr,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          fontSize: isSmallScreen ? 18 : 20,
                          color: isDarkMode ? Colors.white : AppColors.text800,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: isSmallScreen ? 16 : 24),

                // Email/Phone Input Field
                TextField(
                  decoration: InputDecoration(
                    hintText: 'enter_email_phone'.tr,
                    hintStyle: AppTextStyles.inputHint.copyWith(
                      fontSize: isSmallScreen ? 14 : null,
                      color: isDarkMode ? Colors.white.withOpacity(0.7) : null,
                    ),
                    filled: true,
                    fillColor: isDarkMode ? AppColors.darkCardBackground : Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: isDarkMode ? Colors.transparent : AppColors.text200,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: isDarkMode ? Colors.transparent : AppColors.text200,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: isDarkMode ? AppColors.primary500 : AppColors.primary500,
                        width: 2,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                  style: AppTextStyles.inputText.copyWith(
                    fontSize: isSmallScreen ? 14 : null,
                    color: isDarkMode ? Colors.white : AppColors.text800,
                  ),
                ),

                const SizedBox(height: 16),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Image.asset(
                        'assets/icons/warning.png',
                        width: 16,
                        height: 16,
                        color: isDarkMode ? Colors.white.withOpacity(0.7) : null,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'notification_info'.tr,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: isSmallScreen ? 12 : 14,
                          color: isDarkMode ? Colors.white.withOpacity(0.7) : AppColors.text500,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: isSmallScreen ? 16 : 24),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => Get.toNamed(AppRoutes.otpVerification),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary500,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'continue'.tr,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: isSmallScreen ? 14 : 16,
                        color: Colors.white,
                        height: 1.2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}