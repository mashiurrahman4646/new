import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Settings/appearance/ThemeController.dart';
import '../reuseablenav/reuseablenavui.dart';
import '../routes/app_routes.dart';
import 'main_home_page_controller.dart';


class MainHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    final ThemeController themeController = Get.find<ThemeController>();
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // Define colors based on theme
    final backgroundColor = themeController.isDarkModeActive ? Color(0xFF121212) : Colors.white;
    final cardColor = themeController.isDarkModeActive ? Color(0xFF1E1E1E) : Color(0xFFF8F9FA);
    final textColor = themeController.isDarkModeActive ? Colors.white : Colors.black;
    final secondaryTextColor = themeController.isDarkModeActive ? Colors.grey.shade400 : Colors.grey.shade600;
    final iconColor = themeController.isDarkModeActive ? Colors.grey.shade400 : Colors.grey.shade600;
    final primaryColor = Color(0xFF2196F3);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.02),
                // Header with Profile, Greeting, Location, and Notification
                Row(
                  children: [
                    Container(
                      width: screenWidth * 0.12,
                      height: screenWidth * 0.12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: secondaryTextColor, width: 1),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(60)),
                        child: Image.asset(
                          'assets/images/profile_pic.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.03),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'hi_user'.tr,
                            style: TextStyle(
                              fontSize: screenWidth * 0.045,
                              fontWeight: FontWeight.w600,
                              color: textColor,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.005),
                          Text(
                            'location'.tr,
                            style: TextStyle(
                              fontSize: screenWidth * 0.035,
                              color: secondaryTextColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => controller.navigateToNotification(),
                      child: Container(
                        width: screenWidth * 0.11,
                        height: screenWidth * 0.11,
                        decoration: BoxDecoration(
                          color: themeController.isDarkModeActive ? Color(0xFF2D2D2D) : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(screenWidth * 0.03),
                        ),
                        child: Center(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Icon(Icons.notifications_none, color: iconColor),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                  width: screenWidth * 0.02,
                                  height: screenWidth * 0.02,
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03),
                // Month Dropdown Simulation
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03, vertical: screenHeight * 0.01),
                      decoration: BoxDecoration(
                        border: Border.all(color: primaryColor),
                        borderRadius: BorderRadius.circular(screenWidth * 0.03),
                      ),
                      child: Row(
                        children: [
                          Text(
                            controller.getCurrentMonth(),
                            style: TextStyle(
                              fontSize: screenWidth * 0.035,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.01),
                          Icon(
                            Icons.arrow_drop_down,
                            color: primaryColor,
                            size: screenWidth * 0.04,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03),
                // Available Balance Card
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
                    ),
                    borderRadius: BorderRadius.circular(screenWidth * 0.04),
                  ),
                  padding: EdgeInsets.all(screenWidth * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'available_balance'.tr,
                            style: TextStyle(
                              fontSize: screenWidth * 0.04,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.02),
                          Icon(Icons.keyboard_arrow_down, color: Colors.white, size: screenWidth * 0.05),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Center(
                        child: Obx(() => Text(
                          '\$${controller.availableBalance.value}',
                          style: TextStyle(
                            fontSize: screenWidth * 0.1,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        )),
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Obx(() => _buildStatCard('income'.tr, '\$${controller.income.value}', Icons.arrow_upward, Colors.green, screenWidth))),
                          SizedBox(width: screenWidth * 0.04),
                          Expanded(child: Obx(() => _buildStatCard('expense'.tr, '\$${controller.expense.value}', Icons.arrow_downward, Colors.orange, screenWidth))),
                          SizedBox(width: screenWidth * 0.04),
                          Expanded(child: Obx(() => _buildStatCard('savings'.tr, '\$${controller.savings.value}', Icons.add, Colors.white, screenWidth))),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                // Monthly Budget Section
                Container(
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(screenWidth * 0.04),
                  ),
                  padding: EdgeInsets.all(screenWidth * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('monthly_budget'.tr, style: TextStyle(fontSize: screenWidth * 0.045, fontWeight: FontWeight.w600, color: textColor)),
                          GestureDetector(
                            onTap: () => controller.navigateToMonthlyBudgetnonpro(),
                            child: Text('edit'.tr, style: TextStyle(color: primaryColor, fontSize: screenWidth * 0.035)),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Row(
                        children: [
                          Obx(() => Text(
                            '\$${controller.monthlyBudget.value}',
                            style: TextStyle(
                              fontSize: screenWidth * 0.06,
                              fontWeight: FontWeight.w700,
                              color: primaryColor,
                            ),
                          )),
                          SizedBox(width: screenWidth * 0.02),
                          Icon(Icons.arrow_forward_ios, size: screenWidth * 0.04, color: iconColor),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        'keep_it_up'.tr,
                        style: TextStyle(color: secondaryTextColor, fontSize: screenWidth * 0.035),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Obx(() => Container(
                        width: double.infinity,
                        height: screenHeight * 0.01,
                        decoration: BoxDecoration(
                          color: themeController.isDarkModeActive ? Color(0xFF3A3A3A) : Color(0xFFC0C0C0),
                          borderRadius: BorderRadius.circular(screenWidth * 0.02),
                        ),
                        child: Stack(
                          children: [
                            Container(
                              width: screenWidth * 0.8 * (controller.spentPercentage.value / 100),
                              height: screenHeight * 0.01,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(screenWidth * 0.02),
                              ),
                            ),
                          ],
                        ),
                      )),
                      SizedBox(height: screenHeight * 0.015),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(() => Text(
                            '${'spent'.tr} \$${controller.spentAmount.value}/${controller.spentPercentage.value.toStringAsFixed(0)}%',
                            style: TextStyle(color: secondaryTextColor, fontWeight: FontWeight.w500, fontSize: screenWidth * 0.035),
                          )),
                          Obx(() => Text(
                            '${'left'.tr} \$${controller.leftAmount.value}/${controller.leftPercentage.value.toStringAsFixed(0)}%',
                            style: TextStyle(color: secondaryTextColor, fontWeight: FontWeight.w500, fontSize: screenWidth * 0.035),
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                // Rate App Section
                Container(
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(screenWidth * 0.04),
                  ),
                  padding: EdgeInsets.all(screenWidth * 0.06),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('rate_app'.tr, style: TextStyle(fontSize: screenWidth * 0.045, fontWeight: FontWeight.w600, color: textColor)),
                      SizedBox(height: screenHeight * 0.03),
                      Text(
                        'lets_grow'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: screenWidth * 0.05, fontWeight: FontWeight.w600, color: textColor),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        'feedback_help'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: secondaryTextColor, fontSize: screenWidth * 0.035),
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                            child: GestureDetector(
                              onTap: () => controller.setStarRating(index + 1),
                              child: Image.asset(
                                'assets/icons/star.png',
                                width: screenWidth * 0.07,
                                height: screenWidth * 0.07,
                                color: index < controller.starRating.value ? primaryColor : iconColor,
                              ),
                            ),
                          );
                        }),
                      )),
                      SizedBox(height: screenHeight * 0.03),
                      SizedBox(
                        width: double.infinity,
                        height: screenHeight * 0.06,
                        child: ElevatedButton(
                          onPressed: () => controller.shareExperience(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(screenWidth * 0.03)),
                          ),
                          child: Text(
                            'share_experience'.tr,
                            style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                // Recent Transactions
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('recent_transaction'.tr, style: TextStyle(fontSize: screenWidth * 0.045, fontWeight: FontWeight.w600, color: textColor)),
                    GestureDetector(
                      onTap: () => controller.viewAllTransactions(),
                      child: Text('view_all'.tr, style: TextStyle(color: primaryColor, fontSize: screenWidth * 0.035)),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                Obx(() => Column(
                  children: controller.recentTransactions.asMap().entries.map((entry) {
                    var transaction = entry.value;
                    return Padding(
                      padding: EdgeInsets.only(bottom: screenHeight * 0.015),
                      child: _buildTransactionItem(
                        transaction['title'] as String,
                        transaction['time'] as String,
                        transaction['amount'] as String,
                        transaction['isIncome'] as bool,
                        screenWidth,
                        themeController.isDarkModeActive,
                      ),
                    );
                  }).toList(),
                )),
                SizedBox(height: screenHeight * 0.03),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        isDarkMode: themeController.isDarkModeActive,
      ),
    );
  }

  Widget _buildStatCard(String title, String amount, IconData icon, Color color, double screenWidth) {
    return Container(
      height: screenWidth * 0.23,
      decoration: BoxDecoration(
        color: const Color(0xFF2A6EBB).withOpacity(0.5),
        borderRadius: BorderRadius.circular(screenWidth * 0.02),
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 0.2),
      ),
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02, horizontal: screenWidth * 0.03),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: screenWidth * 0.03,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: screenWidth * 0.01),
          Text(
            amount,
            style: TextStyle(
              fontSize: screenWidth * 0.045,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: screenWidth * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: screenWidth * 0.05,
                color: color,
              ),
              SizedBox(width: screenWidth * 0.01),
              Text(
                '+15%',
                style: TextStyle(
                  color: color,
                  fontSize: screenWidth * 0.035,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(String title, String time, String amount, bool isIncome, double screenWidth, bool isDarkMode) {
    return Card(
      color: isDarkMode ? Color(0xFF1E1E1E) : Colors.white,
      elevation: 0.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
      ),
      margin: EdgeInsets.zero,
      child: Container(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Row(
          children: [
            Container(
              width: screenWidth * 0.1,
              height: screenWidth * 0.1,
              decoration: BoxDecoration(
                color: isDarkMode ? Color(0xFF2D2D2D) : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(screenWidth * 0.02),
              ),
              child: Center(
                child: Icon(
                  isIncome ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
                  size: screenWidth * 0.05,
                  color: isIncome ? const Color(0xFF4CAF50) : const Color(0xFFF57C00),
                ),
              ),
            ),
            SizedBox(width: screenWidth * 0.03),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? Colors.white : Colors.black,
                  )),
                  Text(time, style: TextStyle(
                      color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                      fontSize: screenWidth * 0.035
                  )),
                ],
              ),
            ),
            Text(
              '${isIncome ? '+' : '-'}\$$amount',
              style: TextStyle(
                color: isIncome ? const Color(0xFF4CAF50) : const Color(0xFFF57C00),
                fontWeight: FontWeight.w600,
                fontSize: screenWidth * 0.035,
              ),
            ),
          ],
        ),
      ),
    );
  }
}