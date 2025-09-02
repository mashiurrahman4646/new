import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Settings/appearance/ThemeController.dart';

class IncomeListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeController = Get.find<ThemeController>();

    // Define colors based on theme
    final backgroundColor = themeController.isDarkModeActive ? Color(0xFF121212) : Colors.white;
    final cardColor = themeController.isDarkModeActive ? Color(0xFF1E1E1E) : Colors.white;
    final textColor = themeController.isDarkModeActive ? Colors.white : Colors.black;
    final secondaryTextColor = themeController.isDarkModeActive ? Colors.grey.shade400 : Colors.grey.shade600;
    final iconColor = themeController.isDarkModeActive ? Colors.grey.shade400 : Colors.grey.shade600;
    final shadowColor = themeController.isDarkModeActive ? Colors.black.withOpacity(0.3) : Colors.grey.withOpacity(0.1);

    // Sample income data
    final List<IncomeItem> incomes = [
      IncomeItem(
        title: 'Food',
        description: 'Bought fruits from the market',
        amount: '\$20.20',
        date: '06/06/25, 09:00 PM',
        icon: 'assets/icons/soft-drink-00.png',
      ),
      IncomeItem(
        title: 'Food',
        description: 'Bought fruits from the market',
        amount: '\$20.20',
        date: '06/06/25, 09:00 PM',
        icon: 'assets/icons/soft-drink-00.png',
      ),
      IncomeItem(
        title: 'Food',
        description: 'Bought fruits from the market',
        amount: '\$20.20',
        date: '06/06/25, 09:00 PM',
        icon: 'assets/icons/soft-drink-00.png',
      ),
      IncomeItem(
        title: 'Food',
        description: 'Bought fruits from the market',
        amount: '\$20.20',
        date: '06/06/25, 09:00 PM',
        icon: 'assets/icons/soft-drink-00.png',
      ),
      IncomeItem(
        title: 'Food',
        description: 'Bought fruits from the market',
        amount: '\$20.20',
        date: '06/06/25, 09:00 PM',
        icon: 'assets/icons/soft-drink-00.png',
      ),
      IncomeItem(
        title: 'Food',
        description: 'Bought fruits from the market',
        amount: '\$20.20',
        date: '06/06/25, 09:00 PM',
        icon: 'assets/icons/soft-drink-00.png',
      ),
      IncomeItem(
        title: 'Food',
        description: 'Bought fruits from the market',
        amount: '\$20.20',
        date: '06/06/25, 09:00 PM',
        icon: 'assets/icons/soft-drink-00.png',
      ),
      IncomeItem(
        title: 'Food',
        description: 'Bought fruits from the market',
        amount: '\$20.20',
        date: '06/06/25, 09:00 PM',
        icon: 'assets/icons/soft-drink-00.png',
      ),
    ];

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: _buildAppBar(screenWidth, textColor, backgroundColor),
      body: ListView.builder(
        padding: EdgeInsets.all(screenWidth * 0.04),
        itemCount: incomes.length,
        itemBuilder: (context, index) {
          return _buildIncomeItem(
              incomes[index],
              screenWidth,
              screenHeight,
              cardColor,
              textColor,
              secondaryTextColor,
              iconColor,
              shadowColor,
              themeController
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(double screenWidth, Color textColor, Color backgroundColor) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      leading: GestureDetector(
        onTap: () => Get.back(),
        child: Icon(
          Icons.arrow_back_ios,
          color: textColor,
          size: screenWidth * 0.05,
        ),
      ),
      title: Text(
        'Income List',
        style: TextStyle(
          color: textColor,
          fontSize: screenWidth * 0.045,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildIncomeItem(
      IncomeItem income,
      double screenWidth,
      double screenHeight,
      Color cardColor,
      Color textColor,
      Color secondaryTextColor,
      Color iconColor,
      Color shadowColor,
      ThemeController themeController
      ) {
    return Container(
      margin: EdgeInsets.only(bottom: screenHeight * 0.015),
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon container
          Container(
            width: screenWidth * 0.12,
            height: screenWidth * 0.12,
            decoration: BoxDecoration(
              color: themeController.isDarkModeActive ? Color(0xFF2D2D2D) : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(screenWidth * 0.02),
            ),
            child: Center(
              child: Image.asset(
                income.icon,
                width: screenWidth * 0.06,
                height: screenWidth * 0.06,
                color: iconColor,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.fastfood,
                    size: screenWidth * 0.06,
                    color: iconColor,
                  );
                },
              ),
            ),
          ),

          SizedBox(width: screenWidth * 0.04),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  income.title,
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
                SizedBox(height: screenHeight * 0.005),
                Text(
                  income.description,
                  style: TextStyle(
                    fontSize: screenWidth * 0.032,
                    color: secondaryTextColor,
                  ),
                ),
                SizedBox(height: screenHeight * 0.008),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: screenWidth * 0.035,
                      color: secondaryTextColor,
                    ),
                    SizedBox(width: screenWidth * 0.01),
                    Text(
                      income.date,
                      style: TextStyle(
                        fontSize: screenWidth * 0.03,
                        color: secondaryTextColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Amount and edit button
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                income.amount,
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              GestureDetector(
                onTap: () {
                  // Handle edit action
                  print('Edit income: ${income.title}');
                },
                child: Container(
                  padding: EdgeInsets.all(screenWidth * 0.02),
                  child: Image.asset(
                    'assets/icons/edit-00.png',
                    width: screenWidth * 0.05,
                    height: screenWidth * 0.05,
                    color: iconColor,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.edit,
                        size: screenWidth * 0.05,
                        color: iconColor,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class IncomeItem {
  final String title;
  final String description;
  final String amount;
  final String date;
  final String icon;

  IncomeItem({
    required this.title,
    required this.description,
    required this.amount,
    required this.date,
    required this.icon,
  });
}