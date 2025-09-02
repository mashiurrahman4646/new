import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../Settings/appearance/ThemeController.dart'; // Import your ThemeController

class AddCategoryScreen extends StatefulWidget {
  final bool isExpense;

  const AddCategoryScreen({Key? key, required this.isExpense}) : super(key: key);

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final TextEditingController categoryController = TextEditingController();
  String? selectedIconId;
  final themeController = Get.find<ThemeController>();

  // Base icons list with unique IDs
  final List<Map<String, String>> baseIcons = [
    {'id': 'money1', 'path': 'money.oc.png'},
    {'id': 'language1', 'path': 'language-square.png'},
    {'id': 'btc1', 'path': 'btc.png'},
    {'id': 'computer1', 'path': 'computer-dollar.png'},
    {'id': 'credit1', 'path': 'credit-card-validation.png'},
    {'id': 'money2', 'path': 'money.oc.png'},
    {'id': 'language2', 'path': 'language-square.png'},
    {'id': 'btc2', 'path': 'btc.png'},
    {'id': 'computer2', 'path': 'computer-dollar.png'},
    {'id': 'credit2', 'path': 'credit-card-validation.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      backgroundColor: themeController.isDarkModeActive ? const Color(0xFF121212) : Colors.white,
      appBar: AppBar(
        backgroundColor: themeController.isDarkModeActive ? const Color(0xFF1E1E1E) : Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: themeController.isDarkModeActive ? Colors.white : Colors.black, size: 20),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'addCategoryTitle'.tr,
          style: TextStyle(
            color: themeController.isDarkModeActive ? Colors.white : Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // Category Name
            Text(
              'categoryName'.tr,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: themeController.isDarkModeActive ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 12),

            // Text Field
            Container(
              decoration: BoxDecoration(
                color: themeController.isDarkModeActive ? const Color(0xFF2A2A2A) : Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: themeController.isDarkModeActive ? Colors.grey[700]! : Colors.grey[300]!),
              ),
              child: TextField(
                controller: categoryController,
                style: TextStyle(
                  fontSize: 14,
                  color: themeController.isDarkModeActive ? Colors.white : Colors.black87,
                ),
                decoration: InputDecoration(
                  hintText: 'categoryNameHint'.tr,
                  hintStyle: TextStyle(
                    color: themeController.isDarkModeActive ? Colors.grey[400] : Colors.grey,
                    fontSize: 14,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Choose an Icon
            Text(
              'chooseIcon'.tr,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: themeController.isDarkModeActive ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 20),

            // Icons Grid - Two rows with 5 icons each
            Column(
              children: [
                // First row with first 5 icons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: baseIcons.sublist(0, 5).map((icon) {
                    return _buildIconButton(icon, themeController.isDarkModeActive);
                  }).toList(),
                ),
                const SizedBox(height: 16),

                // Second row with remaining 5 icons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: baseIcons.sublist(5).map((icon) {
                    return _buildIconButton(icon, themeController.isDarkModeActive);
                  }).toList(),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Add Button
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (categoryController.text.isNotEmpty && selectedIconId != null) {
                    final selectedIcon = baseIcons.firstWhere(
                          (icon) => icon['id'] == selectedIconId,
                      orElse: () => {'id': '', 'path': ''},
                    );
                    Get.back(result: {
                      'name': categoryController.text,
                      'icon': selectedIcon['path'],
                      'iconPath': 'assets/icons/${selectedIcon['path']}',
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'add'.tr,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const Spacer(),
          ],
        ),
      ),
    ));
  }

  Widget _buildIconButton(Map<String, String> icon, bool isDarkMode) {
    bool isSelected = selectedIconId == icon['id'];
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIconId = icon['id'];
        });
      },
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF2A2A2A) : Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? Border.all(color: Colors.blue, width: 2)
              : null,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Image.asset(
            'assets/icons/${icon['path']}',
            width: 24,
            height: 24,
            color: isDarkMode ? Colors.white : Colors.black54,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.category,
                size: 24,
                color: isDarkMode ? Colors.white : Colors.black54,
              );
            },
          ),
        ),
      ),
    );
  }
}