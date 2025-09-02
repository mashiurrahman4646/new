import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../appearance/ThemeController.dart';
// CHANGE THIS IMPORT - point to your current verification screen
import 'EmailVerificationScreen.dart'; // Make sure this points to your verification screen with PersonalInfo navigation

class ChangeEmailScreen extends StatelessWidget {
  final TextEditingController currentEmailController = TextEditingController();
  final TextEditingController newEmailController = TextEditingController();
  final TextEditingController confirmEmailController = TextEditingController();
  final ThemeController themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: themeController.isDarkModeActive ? Color(0xFF121212) : Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: themeController.isDarkModeActive ? Color(0xFF1E1E1E) : Color(0xFFF8F9FA),
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
          'change_email'.tr,
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
            children: [
              SizedBox(height: screenHeight * 0.08),

              // Email Icon
              Container(
                width: screenWidth * 0.15,
                height: screenWidth * 0.15,
                decoration: BoxDecoration(
                  color: themeController.isDarkModeActive ? Color(0xFF2D2D2D) : const Color(0xFF2196F3).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.email_outlined,
                  size: screenWidth * 0.08,
                  color: const Color(0xFF2196F3),
                ),
              ),

              SizedBox(height: screenHeight * 0.04),

              // Description Text
              Text(
                'email_change_description'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  color: themeController.isDarkModeActive ? Color(0xFF9CA3AF) : const Color(0xFF6B7280),
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                ),
              ),

              SizedBox(height: screenHeight * 0.06),

              // Current Email Address
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'current_email'.tr,
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      color: themeController.isDarkModeActive ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  TextField(
                    controller: currentEmailController,
                    style: TextStyle(
                      color: themeController.isDarkModeActive ? Colors.white : Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: 'email_example'.tr,
                      hintStyle: TextStyle(
                        color: themeController.isDarkModeActive ? Colors.grey.shade400 : Colors.grey.shade400,
                        fontSize: screenWidth * 0.035,
                      ),
                      filled: true,
                      fillColor: themeController.isDarkModeActive ? Color(0xFF1E1E1E) : Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.02),
                        borderSide: BorderSide(color: themeController.isDarkModeActive ? Color(0xFF3A3A3A) : Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.02),
                        borderSide: BorderSide(color: themeController.isDarkModeActive ? Color(0xFF3A3A3A) : Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.02),
                        borderSide: BorderSide(color: const Color(0xFF2196F3)),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.04,
                        vertical: screenHeight * 0.018,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.025),

              // New Email Address
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'new_email'.tr,
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      color: themeController.isDarkModeActive ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  TextField(
                    controller: newEmailController,
                    style: TextStyle(
                      color: themeController.isDarkModeActive ? Colors.white : Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: 'email_example'.tr,
                      hintStyle: TextStyle(
                        color: themeController.isDarkModeActive ? Colors.grey.shade400 : Colors.grey.shade400,
                        fontSize: screenWidth * 0.035,
                      ),
                      filled: true,
                      fillColor: themeController.isDarkModeActive ? Color(0xFF1E1E1E) : Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.02),
                        borderSide: BorderSide(color: themeController.isDarkModeActive ? Color(0xFF3A3A3A) : Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.02),
                        borderSide: BorderSide(color: themeController.isDarkModeActive ? Color(0xFF3A3A3A) : Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.02),
                        borderSide: BorderSide(color: const Color(0xFF2196F3)),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.04,
                        vertical: screenHeight * 0.018,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.025),

              // Confirm Email Address
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'confirm_email'.tr,
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      color: themeController.isDarkModeActive ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  TextField(
                    controller: confirmEmailController,
                    style: TextStyle(
                      color: themeController.isDarkModeActive ? Colors.white : Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: 'email_example'.tr,
                      hintStyle: TextStyle(
                        color: themeController.isDarkModeActive ? Colors.grey.shade400 : Colors.grey.shade400,
                        fontSize: screenWidth * 0.035,
                      ),
                      filled: true,
                      fillColor: themeController.isDarkModeActive ? Color(0xFF1E1E1E) : Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.02),
                        borderSide: BorderSide(color: themeController.isDarkModeActive ? Color(0xFF3A3A3A) : Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.02),
                        borderSide: BorderSide(color: themeController.isDarkModeActive ? Color(0xFF3A3A3A) : Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.02),
                        borderSide: BorderSide(color: const Color(0xFF2196F3)),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.04,
                        vertical: screenHeight * 0.018,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.06),

              // Submit Button
              Container(
                width: double.infinity,
                height: screenHeight * 0.06,
                child: ElevatedButton(
                  onPressed: () {
                    // Add basic email validation
                    if (newEmailController.text.isEmpty ||
                        confirmEmailController.text.isEmpty ||
                        currentEmailController.text.isEmpty) {
                      Get.snackbar(
                        'error'.tr,
                        'fill_all_fields'.tr,
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                      return;
                    }

                    if (newEmailController.text != confirmEmailController.text) {
                      Get.snackbar(
                        'error'.tr,
                        'email_mismatch'.tr,
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                      return;
                    }

                    // Navigate to your verification screen (the one with PersonalInfo navigation)
                    print("Navigating to EmailVerificationScreen");
                    Get.to(() => EmailVerificationScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2196F3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.03),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'submit'.tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}