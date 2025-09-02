import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_expense/Settings/userprofile/passwordchangescreen.dart';
import '../../routes/app_routes.dart';
import 'changeemail.dart';
import '../appearance/ThemeController.dart';

class PersonalInformationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
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
          onPressed: () {
            bool routeFound = false;

            // Try to pop until we find the settings route
            Get.until((route) {
              if (route.settings.name == AppRoutes.settings) {
                routeFound = true;
              }
              return route.settings.name == AppRoutes.settings;
            });

            // If not found, navigate fresh to settings
            if (!routeFound) {
              Get.offAllNamed(AppRoutes.settings);
            }
          },
        ),
        title: Text(
          'personal_information'.tr,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.03),

              // Profile Section
              Center(
                child: Column(
                  children: [
                    Container(
                      width: screenWidth * 0.25,
                      height: screenWidth * 0.25,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: themeController.isDarkModeActive ? Color(0xFF1E1E1E) : Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(screenWidth * 0.125),
                        child: Image.asset(
                          'assets/images/Ellipse 5.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    // Change Photo Button
                    GestureDetector(
                      onTap: () {
                        Get.snackbar(
                          'photo_snackbar_title'.tr,
                          'photo_snackbar_message'.tr,
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: themeController.isDarkModeActive ? Color(0xFF2D2D2D) : Color(0xFF2196F3),
                          colorText: themeController.isDarkModeActive ? Colors.white : Colors.white,
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.05,
                          vertical: screenHeight * 0.012,
                        ),
                        decoration: BoxDecoration(
                          color: themeController.isDarkModeActive ? Color(0xFF1E1E1E) : Colors.white,
                          borderRadius: BorderRadius.circular(screenWidth * 0.06),
                          border: Border.all(
                            color: themeController.isDarkModeActive ? Color(0xFF3A3A3A) : Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          'change_photo'.tr,
                          style: TextStyle(
                            fontSize: screenWidth * 0.035,
                            color: themeController.isDarkModeActive ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: screenHeight * 0.05),

              // Personal Information Section
              Text(
                'personal_information'.tr,
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w600,
                  color: themeController.isDarkModeActive ? Colors.white : Colors.black,
                ),
              ),

              SizedBox(height: screenHeight * 0.025),

              _buildInfoItem(
                'full_name'.tr,
                'full_name_subtitle'.tr,
                    () => Get.toNamed(AppRoutes.editName),
                screenWidth,
                screenHeight,
                themeController.isDarkModeActive,
              ),

              _buildInfoItem(
                'email_address'.tr,
                'johndoe@example.com',
                    () => Get.to(() => ChangeEmailScreen()),
                screenWidth,
                screenHeight,
                themeController.isDarkModeActive,
              ),

              _buildInfoItem(
                'change_password'.tr,
                '',
                    () => Get.to(() => PasswordChangeScreen()),
                screenWidth,
                screenHeight,
                themeController.isDarkModeActive,
              ),

              SizedBox(height: screenHeight * 0.06),

              // Delete Account Button
              SizedBox(
                width: double.infinity,
                height: screenHeight * 0.06,
                child: ElevatedButton(
                  onPressed: () {
                    Get.dialog(
                      AlertDialog(
                        backgroundColor: themeController.isDarkModeActive ? Color(0xFF1E1E1E) : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        title: Text(
                          'delete_account_title'.tr,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.red,
                          ),
                        ),
                        content: Text(
                          'delete_account_message'.tr,
                          style: TextStyle(
                            color: themeController.isDarkModeActive ? Colors.white70 : Colors.black87,
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Get.back(),
                            child: Text(
                              'cancel'.tr,
                              style: TextStyle(
                                color: themeController.isDarkModeActive ? Colors.grey.shade400 : Colors.grey.shade600,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.back();
                              Get.snackbar(
                                'account_deleted'.tr,
                                'account_deleted_message'.tr,
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                              );
                            },
                            child: Text(
                              'delete'.tr,
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2196F3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.03),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'delete_account'.tr,
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

  Widget _buildInfoItem(
      String title,
      String subtitle,
      VoidCallback onTap,
      double screenWidth,
      double screenHeight,
      bool isDarkMode,
      ) {
    return Container(
      margin: EdgeInsets.only(bottom: screenHeight * 0.02),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(screenWidth * 0.02),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.02,
              vertical: screenHeight * 0.02,
            ),
            decoration: BoxDecoration(
              color: isDarkMode ? Color(0xFF1E1E1E) : Colors.transparent,
              borderRadius: BorderRadius.circular(screenWidth * 0.02),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: screenWidth * 0.042,
                          fontWeight: FontWeight.w600,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      if (subtitle.isNotEmpty) ...[
                        SizedBox(height: screenHeight * 0.005),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: screenWidth * 0.035,
                            color: isDarkMode ? Color(0xFF9CA3AF) : Color(0xFF6B7280),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: screenWidth * 0.04,
                  color: isDarkMode ? Color(0xFF9CA3AF) : Color(0xFF9CA3AF),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}