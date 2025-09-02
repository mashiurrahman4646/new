import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Settings/appearance/ThemeController.dart';

class MonthlyBudgetScreen extends StatelessWidget {
  const MonthlyBudgetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
    final bool isDarkMode = themeController.isDarkModeActive;

    final Color backgroundColor = isDarkMode ? Color(0xFF121212) : Color(0xFFF8F9FA);
    final Color cardColor = isDarkMode ? Color(0xFF1E1E1E) : Colors.white;
    final Color textColor = isDarkMode ? Colors.white : Colors.black;
    final Color secondaryTextColor = isDarkMode ? Colors.grey[400]! : Color(0xFF6A6A6A);
    final Color borderColor = isDarkMode ? Color(0xFF333333) : Color(0xFFE0E0E0);
    final Color lightBorderColor = isDarkMode ? Color(0xFF444444) : Color(0xFFF0F0F0);
    final Color hintTextColor = isDarkMode ? Colors.grey[500]! : Color(0xFF9E9E9E);
    final Color iconBackgroundColor = isDarkMode ? Color(0xFF2A2A2A) : Color(0xFFF8F9FA);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          "monthly_budget".tr,
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: textColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: backgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: textColor, size: 20),
          onPressed: () => Get.offAllNamed('/mainHome'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),

            // Current Monthly Budget Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: isDarkMode ? null : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'current_monthly_budget'.tr,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: secondaryTextColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$25000',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 32,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Edit Budget Section
            Text(
              'edit_your_budget'.tr,
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: textColor,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: borderColor),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'enter_amount'.tr,
                  hintStyle: TextStyle(
                    color: hintTextColor,
                    fontSize: 16,
                    fontFamily: 'Inter',
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                ),
                style: TextStyle(
                  fontSize: 16,
                  color: textColor,
                  fontFamily: 'Inter',
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: hintTextColor, width: 1.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.info_outline,
                    size: 12,
                    color: hintTextColor,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'budget_change_info'.tr,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: secondaryTextColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Confirm Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2196F3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'confirm'.tr,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Select Category Section
            Text(
              'select_category'.tr,
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: textColor,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: isDarkMode ? null : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCategoryItem('food'.tr, 'assets/icons/soft-drink-01.png', iconBackgroundColor, borderColor, secondaryTextColor),
                  _buildCategoryItem('transport'.tr, 'assets/icons/car.png', iconBackgroundColor, borderColor, secondaryTextColor),
                  _buildCategoryItem('groceries'.tr, 'assets/icons/Groceries.png', iconBackgroundColor, borderColor, secondaryTextColor),
                  _buildCategoryItem('eating_out'.tr, 'assets/icons/eating_out.png', iconBackgroundColor, borderColor, secondaryTextColor),
                  _buildCategoryItem('home'.tr, 'assets/icons/home_icon.png', iconBackgroundColor, borderColor, secondaryTextColor),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildAddCategoryButton(cardColor, borderColor, textColor),
            const SizedBox(height: 32),

            // Budget Distribution Section
            Text(
              'budget_distribution'.tr,
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: textColor,
              ),
            ),
            const SizedBox(height: 16),
            Column(
              children: [
                _buildBudgetListItem('food'.tr, '\$120', '15%', 'assets/icons/soft-drink-01.png', cardColor, lightBorderColor, textColor, secondaryTextColor, iconBackgroundColor),
                const SizedBox(height: 8),
                _buildBudgetListItem('transport'.tr, '\$100', '7%', 'assets/icons/car.png', cardColor, lightBorderColor, textColor, secondaryTextColor, iconBackgroundColor),
                const SizedBox(height: 8),
                _buildBudgetListItem('groceries'.tr, '\$50', '5%', 'assets/icons/Groceries.png', cardColor, lightBorderColor, textColor, secondaryTextColor, iconBackgroundColor),
                const SizedBox(height: 8),
                _buildBudgetListItem('eating_out'.tr, '\$300', '25%', 'assets/icons/eating_out.png', cardColor, lightBorderColor, textColor, secondaryTextColor, iconBackgroundColor),
                const SizedBox(height: 8),
                _buildBudgetListItem('home'.tr, '\$200', '20%', 'assets/icons/home_icon.png', cardColor, lightBorderColor, textColor, secondaryTextColor, iconBackgroundColor),
                const SizedBox(height: 8),
                _buildBudgetListItem('gift'.tr, '\$100', '7%', 'assets/icons/gift.png', cardColor, lightBorderColor, textColor, secondaryTextColor, iconBackgroundColor),
                const SizedBox(height: 8),
                _buildBudgetListItem('shopping'.tr, '\$20', '2%', 'assets/icons/shoping.png', cardColor, lightBorderColor, textColor, secondaryTextColor, iconBackgroundColor),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(String label, String iconPath, Color iconBackgroundColor, Color borderColor, Color textColor) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconBackgroundColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: borderColor),
            ),
            child: Center(
              child: Image.asset(
                iconPath,
                width: 24,
                height: 24,
                color: textColor, // Added color filter to make icons adapt to theme
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.category,
                    size: 24,
                    color: textColor,
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: textColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAddCategoryButton(Color cardColor, Color borderColor, Color textColor) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/addCategory');
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: textColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.add,
                color: cardColor,
                size: 14,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'add_custom_category'.tr,
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBudgetListItem(
      String category, String amount, String percentage, String iconPath,
      Color cardColor, Color borderColor, Color textColor, Color secondaryTextColor, Color iconBackgroundColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: iconBackgroundColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Image.asset(
                iconPath,
                width: 18,
                height: 18,
                color: textColor, // Added color filter to make icons adapt to theme
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.category,
                    size: 18,
                    color: textColor,
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              category,
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: textColor,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                amount,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: textColor,
                ),
              ),
              Text(
                percentage,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 11,
                  color: secondaryTextColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}