import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../appearance/ThemeController.dart';
 // Import your ThemeController

class NotificationSettingsScreen extends StatefulWidget {
  @override
  _NotificationSettingsScreenState createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  bool enableAllNotifications = true;
  bool pushNotification = true;
  bool automaticRenewal = true;
  bool monthlyExpenseAndIncomeAlerts = true;
  bool budgetLimitWarning = true;
  bool promotionalNotifications = true;

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Obx(() => Scaffold(
      backgroundColor: themeController.isDarkModeActive
          ? const Color(0xFF121212)
          : Colors.white,
      appBar: AppBar(
        backgroundColor: themeController.isDarkModeActive
            ? const Color(0xFF1E1E1E)
            : Colors.white,
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
          'notification_settings'.tr,
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
              SizedBox(height: screenHeight * 0.02),

              // Enable All Notifications
              _buildNotificationItem(
                icon: Icons.notifications_outlined,
                title: 'enable_all_notifications'.tr,
                subtitle: 'enable_all_notifications_desc'.tr,
                value: enableAllNotifications,
                onChanged: (value) {
                  setState(() {
                    enableAllNotifications = value;
                    if (!value) {
                      // Turn off all notifications
                      pushNotification = false;
                      automaticRenewal = false;
                      monthlyExpenseAndIncomeAlerts = false;
                      budgetLimitWarning = false;
                      promotionalNotifications = false;
                    }
                  });
                },
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                isDarkMode: themeController.isDarkModeActive,
              ),

              SizedBox(height: screenHeight * 0.02),

              // General Notifications Section
              Text(
                'general_notifications'.tr,
                style: TextStyle(
                  fontSize: screenWidth * 0.038,
                  fontWeight: FontWeight.w500,
                  color: themeController.isDarkModeActive
                      ? Colors.grey[400]
                      : const Color(0xFF6B7280),
                ),
              ),

              SizedBox(height: screenHeight * 0.015),

              _buildNotificationItem(
                icon: Icons.notifications_active_outlined,
                title: 'push_notification'.tr,
                subtitle: 'push_notification_desc'.tr,
                value: pushNotification,
                onChanged: (value) {
                  setState(() {
                    pushNotification = value;
                  });
                },
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                isDarkMode: themeController.isDarkModeActive,
              ),

              _buildNotificationItem(
                icon: Icons.autorenew_outlined,
                title: 'automatic_renewal'.tr,
                subtitle: 'automatic_renewal_desc'.tr,
                value: automaticRenewal,
                onChanged: (value) {
                  setState(() {
                    automaticRenewal = value;
                  });
                },
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                isDarkMode: themeController.isDarkModeActive,
              ),

              SizedBox(height: screenHeight * 0.02),

              // Financial Alerts Section
              Text(
                'financial_alerts'.tr,
                style: TextStyle(
                  fontSize: screenWidth * 0.038,
                  fontWeight: FontWeight.w500,
                  color: themeController.isDarkModeActive
                      ? Colors.grey[400]
                      : const Color(0xFF6B7280),
                ),
              ),

              SizedBox(height: screenHeight * 0.015),

              _buildNotificationItem(
                icon: Icons.receipt_long_outlined,
                title: 'monthly_alerts'.tr,
                subtitle: 'monthly_alerts_desc'.tr,
                value: monthlyExpenseAndIncomeAlerts,
                onChanged: (value) {
                  setState(() {
                    monthlyExpenseAndIncomeAlerts = value;
                  });
                },
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                isDarkMode: themeController.isDarkModeActive,
              ),

              _buildNotificationItem(
                icon: Icons.trending_up_outlined,
                title: 'budget_limit_warning'.tr,
                subtitle: 'budget_limit_warning_desc'.tr,
                value: budgetLimitWarning,
                onChanged: (value) {
                  setState(() {
                    budgetLimitWarning = value;
                  });
                },
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                isDarkMode: themeController.isDarkModeActive,
              ),

              SizedBox(height: screenHeight * 0.02),

              // Other Notifications Section
              Text(
                'other_notifications'.tr,
                style: TextStyle(
                  fontSize: screenWidth * 0.038,
                  fontWeight: FontWeight.w500,
                  color: themeController.isDarkModeActive
                      ? Colors.grey[400]
                      : const Color(0xFF6B7280),
                ),
              ),

              SizedBox(height: screenHeight * 0.015),

              _buildNotificationItem(
                icon: Icons.campaign_outlined,
                title: 'promotional_notifications'.tr,
                subtitle: 'promotional_notifications_desc'.tr,
                value: promotionalNotifications,
                onChanged: (value) {
                  setState(() {
                    promotionalNotifications = value;
                  });
                },
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                isDarkMode: themeController.isDarkModeActive,
              ),

              SizedBox(height: screenHeight * 0.03),

              // Auto Save Message
              Center(
                child: Text(
                  'auto_save_message'.tr,
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
                    color: themeController.isDarkModeActive
                        ? Colors.grey[400]
                        : const Color(0xFF6B7280),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.03),
            ],
          ),
        ),
      ),
    ));
  }

  Widget _buildNotificationItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
    required double screenWidth,
    required double screenHeight,
    required bool isDarkMode,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: screenHeight * 0.02),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            width: screenWidth * 0.12,
            height: screenWidth * 0.12,
            decoration: BoxDecoration(
              color: isDarkMode ? const Color(0xFF2A2A2A) : const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(screenWidth * 0.025),
            ),
            child: Icon(
              icon,
              size: screenWidth * 0.06,
              color: isDarkMode ? Colors.grey[400] : const Color(0xFF6B7280),
            ),
          ),

          SizedBox(width: screenWidth * 0.04),

          // Content
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
                SizedBox(height: screenHeight * 0.005),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
                    color: isDarkMode ? Colors.grey[400] : const Color(0xFF6B7280),
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          // Switch
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF2196F3),
            activeTrackColor: const Color(0xFF2196F3).withOpacity(0.3),
            inactiveThumbColor: isDarkMode ? Colors.grey.shade600 : Colors.grey.shade400,
            inactiveTrackColor: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300,
          ),
        ],
      ),
    );
  }
}