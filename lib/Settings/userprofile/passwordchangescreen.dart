import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../appearance/ThemeController.dart';
import 'passwordvarificationscreen.dart'; // Import your verification screen


class PasswordChangeScreen extends StatelessWidget {
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Obx(() => Scaffold(
      backgroundColor: themeController.isDarkModeActive
          ? Color(0xFF121212)
          : Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: themeController.isDarkModeActive
            ? Color(0xFF1E1E1E)
            : Color(0xFFF8F9FA),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: themeController.isDarkModeActive ? Colors.white : Colors.black,
            size: screenWidth * 0.05,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'password_change'.tr,
          style: TextStyle(
            color: themeController.isDarkModeActive ? Colors.white : Colors.black,
            fontSize: screenWidth * 0.045,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.04),

              // Lock Icon
              Container(
                width: screenWidth * 0.2,
                height: screenWidth * 0.2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: themeController.isDarkModeActive
                      ? Color(0xFF2196F3).withOpacity(0.2)
                      : Color(0xFF2196F3).withOpacity(0.1),
                ),
                child: Icon(
                  Icons.lock_outline,
                  size: screenWidth * 0.1,
                  color: Color(0xFF2196F3),
                ),
              ),

              SizedBox(height: screenHeight * 0.03),

              // Title
              Text(
                'set_new_password'.tr,
                style: TextStyle(
                  fontSize: screenWidth * 0.055,
                  fontWeight: FontWeight.w600,
                  color: themeController.isDarkModeActive ? Colors.white : Colors.black,
                ),
              ),

              SizedBox(height: screenHeight * 0.01),

              // Subtitle
              Text(
                'enter_new_password'.tr,
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  color: themeController.isDarkModeActive ? Color(0xFFA0A0A0) : Color(0xFF6B7280),
                  fontWeight: FontWeight.w400,
                ),
              ),

              SizedBox(height: screenHeight * 0.04),

              // Current Password Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'current_password'.tr,
                    style: TextStyle(
                      fontSize: screenWidth * 0.038,
                      fontWeight: FontWeight.w500,
                      color: themeController.isDarkModeActive ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  TextField(
                    controller: currentPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'enter_current_password'.tr,
                      hintStyle: TextStyle(
                        color: themeController.isDarkModeActive ? Color(0xFFA0A0A0) : Color(0xFF9CA3AF),
                        fontSize: screenWidth * 0.035,
                      ),
                      filled: true,
                      fillColor: themeController.isDarkModeActive ? Color(0xFF1E1E1E) : Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.025),
                        borderSide: BorderSide(
                          color: themeController.isDarkModeActive ? Color(0xFF333333) : Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.025),
                        borderSide: BorderSide(
                          color: themeController.isDarkModeActive ? Color(0xFF333333) : Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.025),
                        borderSide: BorderSide(
                          color: Color(0xFF2196F3),
                          width: 1.5,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.04,
                        vertical: screenHeight * 0.018,
                      ),
                    ),
                    style: TextStyle(
                      color: themeController.isDarkModeActive ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.025),

              // New Password Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'new_password'.tr,
                    style: TextStyle(
                      fontSize: screenWidth * 0.038,
                      fontWeight: FontWeight.w500,
                      color: themeController.isDarkModeActive ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  TextField(
                    controller: newPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'enter_new_password_field'.tr,
                      hintStyle: TextStyle(
                        color: themeController.isDarkModeActive ? Color(0xFFA0A0A0) : Color(0xFF9CA3AF),
                        fontSize: screenWidth * 0.035,
                      ),
                      filled: true,
                      fillColor: themeController.isDarkModeActive ? Color(0xFF1E1E1E) : Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.025),
                        borderSide: BorderSide(
                          color: themeController.isDarkModeActive ? Color(0xFF333333) : Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.025),
                        borderSide: BorderSide(
                          color: themeController.isDarkModeActive ? Color(0xFF333333) : Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.025),
                        borderSide: BorderSide(
                          color: Color(0xFF2196F3),
                          width: 1.5,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.04,
                        vertical: screenHeight * 0.018,
                      ),
                    ),
                    style: TextStyle(
                      color: themeController.isDarkModeActive ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.025),

              // Confirm New Password Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'confirm_new_password'.tr,
                    style: TextStyle(
                      fontSize: screenWidth * 0.038,
                      fontWeight: FontWeight.w500,
                      color: themeController.isDarkModeActive ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  TextField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'confirm_new_password_field'.tr,
                      hintStyle: TextStyle(
                        color: themeController.isDarkModeActive ? Color(0xFFA0A0A0) : Color(0xFF9CA3AF),
                        fontSize: screenWidth * 0.035,
                      ),
                      filled: true,
                      fillColor: themeController.isDarkModeActive ? Color(0xFF1E1E1E) : Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.025),
                        borderSide: BorderSide(
                          color: themeController.isDarkModeActive ? Color(0xFF333333) : Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.025),
                        borderSide: BorderSide(
                          color: themeController.isDarkModeActive ? Color(0xFF333333) : Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.025),
                        borderSide: BorderSide(
                          color: Color(0xFF2196F3),
                          width: 1.5,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.04,
                        vertical: screenHeight * 0.018,
                      ),
                    ),
                    style: TextStyle(
                      color: themeController.isDarkModeActive ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.04),

              // Continue Button
              Container(
                width: double.infinity,
                height: screenHeight * 0.06,
                child: ElevatedButton(
                  onPressed: () {
                    // Validation logic
                    if (currentPasswordController.text.isEmpty) {
                      Get.snackbar(
                        'error'.tr,
                        'enter_current_password_error'.tr,
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                      return;
                    }

                    if (newPasswordController.text != confirmPasswordController.text) {
                      Get.snackbar(
                        'error'.tr,
                        'passwords_not_match'.tr,
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                      return;
                    }

                    if (newPasswordController.text.length < 10) {
                      Get.snackbar(
                        'error'.tr,
                        'password_length_error'.tr,
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                      return;
                    }

                    // If validation passes, navigate to verification screen
                    Get.to(() => PasswordVerificationScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2196F3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.025),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'continue'.tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.02),

              // Password Requirements
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04,
                  vertical: screenHeight * 0.015,
                ),
                decoration: BoxDecoration(
                  color: themeController.isDarkModeActive ? Color(0xFF2D2D2D) : Color(0xFFFFF3CD),
                  borderRadius: BorderRadius.circular(screenWidth * 0.02),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: screenWidth * 0.04,
                      color: themeController.isDarkModeActive ? Color(0xFFFFCC00) : Color(0xFF856404),
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Expanded(
                      child: Text(
                        'password_requirements'.tr,
                        style: TextStyle(
                          fontSize: screenWidth * 0.032,
                          color: themeController.isDarkModeActive ? Color(0xFFFFCC00) : Color(0xFF856404),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: screenHeight * 0.03),
            ],
          ),
        ),
      ),
    ));
  }
}