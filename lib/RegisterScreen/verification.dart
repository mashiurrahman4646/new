import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_expense/RegisterScreen/verification_controller.dart';
import '../Settings/appearance/ThemeController.dart';
import '../Settings/language/language_controller.dart';
import '../colors/app_colors.dart';
import '../text_styles.dart';

class EmailVerificationScreen extends StatelessWidget {
  final VerificationController controller = Get.put(VerificationController());
  final ThemeController themeController = Get.find<ThemeController>();
  final LanguageController languageController = Get.find<LanguageController>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 375;
    final isLargeScreen = screenWidth > 600;

    return Obx(() => Scaffold(
      backgroundColor: themeController.isDarkMode.value ? Color(0xFF121212) : Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(
            'assets/icons/arrow-left.png',
            width: isSmallScreen ? 20 : 24,
            height: isSmallScreen ? 20 : 24,
            color: themeController.isDarkMode.value ? Colors.white : Colors.black,
          ),
          onPressed: () => Get.back(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'verification_title'.tr,
          style: AppTextStyles.heading2.copyWith(
            fontSize: isSmallScreen ? 18 : 20,
            color: themeController.isDarkMode.value ? Colors.white : const Color(0xFF000000),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isSmallScreen ? 16.0 : 24.0,
            vertical: isSmallScreen ? 16.0 : 24.0,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: screenHeight - MediaQuery.of(context).padding.top - kToolbarHeight,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: isSmallScreen ? 40 : 80),

                // Main heading
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 16 : 24),
                  child: Text(
                    'check_email'.tr,
                    style: TextStyle(
                      fontSize: isSmallScreen ? 18 : isLargeScreen ? 22 : 20,
                      fontWeight: FontWeight.w600,
                      color: themeController.isDarkMode.value ? Colors.white : Colors.black,
                      fontFamily: 'Inter',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                SizedBox(height: isSmallScreen ? 12 : 16),

                // Subtitle
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 16 : 24),
                  child: Text(
                    'code_sent'.tr,
                    style: TextStyle(
                      fontSize: isSmallScreen ? 13 : 14,
                      fontWeight: FontWeight.w400,
                      color: themeController.isDarkMode.value ? Color(0xFF919191) : Colors.grey[600],
                      fontFamily: 'Inter',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                SizedBox(height: isSmallScreen ? 30 : 40),

                // OTP Input Fields
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 8 : 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(6, (index) {
                      final fieldSize = isSmallScreen ? 40.0 : isLargeScreen ? 55.0 : 45.0;
                      return Container(
                        width: fieldSize,
                        height: fieldSize,
                        margin: EdgeInsets.symmetric(horizontal: isSmallScreen ? 2 : 4),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: themeController.isDarkMode.value ? Color(0xFF333333) : Colors.grey[300]!,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          color: themeController.isDarkMode.value ? Color(0xFF1F1F1F) : Colors.grey[50],
                        ),
                        child: TextField(
                          controller: controller.otpControllers[index],
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          style: TextStyle(
                            fontSize: isSmallScreen ? 16 : 18,
                            fontWeight: FontWeight.w600,
                            color: themeController.isDarkMode.value ? Colors.white : Colors.black,
                          ),
                          decoration: const InputDecoration(
                            counterText: '',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                          onChanged: (value) {
                            controller.onOtpChanged(index, value);
                          },
                        ),
                      );
                    }),
                  ),
                ),

                SizedBox(height: isSmallScreen ? 30 : 40),

                // Verify Button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 16 : 24),
                  child: SizedBox(
                    width: double.infinity,
                    height: isSmallScreen ? 45 : 50,
                    child: Obx(() => ElevatedButton(
                      onPressed: controller.isVerifyEnabled.value
                          ? () {
                        controller.verifyOtp();
                      }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: controller.isVerifyEnabled.value
                            ? AppColors.primary500
                            : themeController.isDarkMode.value
                            ? Color(0xFF333333)
                            : Colors.grey[300],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'verify_button'.tr,
                        style: TextStyle(
                          fontSize: isSmallScreen ? 15 : 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                          color: controller.isVerifyEnabled.value
                              ? Colors.white
                              : themeController.isDarkMode.value
                              ? Color(0xFF919191)
                              : Colors.grey[500],
                        ),
                      ),
                    )),
                  ),
                ),

                SizedBox(height: isSmallScreen ? 20 : 24),

                // Resend code section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 16 : 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          'no_code_received'.tr,
                          style: TextStyle(
                            fontSize: isSmallScreen ? 13 : 14,
                            fontWeight: FontWeight.w400,
                            color: themeController.isDarkMode.value ? Color(0xFF919191) : Colors.grey[600],
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                      SizedBox(width: isSmallScreen ? 4 : 8),
                      GestureDetector(
                        onTap: () {
                          controller.resendCode();
                        },
                        child: Text(
                          'resend'.tr,
                          style: TextStyle(
                            fontSize: isSmallScreen ? 13 : 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary500,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: isSmallScreen ? 20 : 40),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}