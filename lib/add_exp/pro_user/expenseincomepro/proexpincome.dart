import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
 // Import your ThemeController

import '../../../Settings/appearance/ThemeController.dart';
import '../../../make it pro/AdvertisementPage/add_ui.dart';
import 'proexpincome_controller.dart';

class ProExpensesIncomeScreen extends StatelessWidget {
  const ProExpensesIncomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProExpensesIncomeController());
    final themeController = Get.find<ThemeController>();

    return Obx(() => Scaffold(
      backgroundColor: themeController.isDarkModeActive ? const Color(0xFF121212) : Colors.grey[50],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: themeController.isDarkModeActive ? Colors.white : Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Obx(() => Text(
          controller.currentTab.value == 0 ? 'addExpense'.tr : 'addIncome'.tr,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: themeController.isDarkModeActive ? Colors.white : Colors.black,
          ),
        )),
        centerTitle: true,
        backgroundColor: themeController.isDarkModeActive ? const Color(0xFF1E1E1E) : Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              decoration: BoxDecoration(
                color: themeController.isDarkModeActive ? const Color(0xFF2A2A2A) : Colors.grey[200],
                borderRadius: BorderRadius.circular(25),
              ),
              child: Obx(() => Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => controller.switchToTab(0),
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: controller.currentTab.value == 0
                              ? Colors.blue
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Center(
                          child: Text(
                            'expense'.tr,
                            style: TextStyle(
                              color: controller.currentTab.value == 0
                                  ? Colors.white
                                  : (themeController.isDarkModeActive ? Colors.grey[400] : Colors.grey[600]),
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => controller.switchToTab(1),
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: controller.currentTab.value == 1
                              ? Colors.blue
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Center(
                          child: Text(
                            'income'.tr,
                            style: TextStyle(
                              color: controller.currentTab.value == 1
                                  ? Colors.white
                                  : (themeController.isDarkModeActive ? Colors.grey[400] : Colors.grey[600]),
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (controller.currentTab.value == 0) {
          return controller.isExpenseProUnlocked.value
              ? _buildExpenseTab(controller, themeController.isDarkModeActive)
              : _buildLockedState('expensePro'.tr, controller, true, themeController.isDarkModeActive);
        } else {
          return controller.isIncomeProUnlocked.value
              ? _buildIncomeTab(controller, themeController.isDarkModeActive)
              : _buildLockedState('incomePro'.tr, controller, false, themeController.isDarkModeActive);
        }
      }),
    ));
  }

  Widget _buildLockedState(String type, ProExpensesIncomeController controller, bool isExpense, bool isDarkMode) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock_outline, size: 80, color: isDarkMode ? Colors.grey[600] : Colors.grey[400]),
            const SizedBox(height: 20),
            Text(
              '$type ${'features'.tr}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.grey[800],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'watchToUnlock'.tr,
              style: TextStyle(
                fontSize: 16,
                color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                final unlocked = await Get.to<bool>(
                      () => AdvertisementPage(isFromExpense: isExpense),
                  fullscreenDialog: true,
                );

                if (unlocked == true) {
                  controller.isExpenseProUnlocked.value = true;
                  controller.isIncomeProUnlocked.value = true;
                  controller.currentTab.refresh();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: Text(
                'watchAdToUnlock'.tr,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpenseTab(ProExpensesIncomeController controller, bool isDarkMode) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildReceiptSection(true, isDarkMode),
          const SizedBox(height: 20),
          _buildCategorySection(controller.expenseCategories, true, controller, isDarkMode),
          const SizedBox(height: 20),
          _buildAddCustomCategory(controller, isDarkMode),
          const SizedBox(height: 20),
          _buildAmountSection(controller, isDarkMode),
          const SizedBox(height: 20),
          _buildTextBoxSection(controller, isDarkMode),
          const SizedBox(height: 20),
          _buildPaymentMethodSection(controller, isDarkMode),
          const SizedBox(height: 20),
          _buildDateTimeSection(controller, isDarkMode),
          const SizedBox(height: 20),
          _buildAddButton(controller),
        ],
      ),
    );
  }

  Widget _buildIncomeTab(ProExpensesIncomeController controller, bool isDarkMode) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildReceiptSection(false, isDarkMode),
          const SizedBox(height: 20),
          _buildCategorySection(controller.incomeCategories, false, controller, isDarkMode),
          const SizedBox(height: 20),
          _buildAddCustomCategory(controller, isDarkMode),
          const SizedBox(height: 20),
          _buildAmountSection(controller, isDarkMode),
          const SizedBox(height: 20),
          _buildTextBoxSection(controller, isDarkMode),
          const SizedBox(height: 20),
          _buildPaymentMethodSection(controller, isDarkMode),
          const SizedBox(height: 20),
          _buildDateTimeSection(controller, isDarkMode),
          const SizedBox(height: 20),
          _buildAddButton(controller),
        ],
      ),
    );
  }

  Widget _buildReceiptSection(bool isExpense, bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'scanOrUploadReceipt'.tr,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildReceiptOption(
                'assets/icons/cameraoc.png',
                'camera'.tr,
                isExpense ? Colors.yellow : Colors.green,
                isDarkMode,
              ),
              _buildReceiptOption(
                'assets/icons/barcodescanneroc.png',
                'barcode'.tr,
                isExpense ? Colors.yellow : Colors.green,
                isDarkMode,
              ),
              _buildReceiptOption(
                'assets/icons/galleryoc.png',
                'gallery'.tr,
                isExpense ? Colors.yellow : Colors.green,
                isDarkMode,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReceiptOption(String iconPath, String label, Color backgroundColor, bool isDarkMode) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
            border: Border.all(color: isDarkMode ? Colors.grey[600]! : Colors.black.withOpacity(0.3), width: 1.5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset(
              iconPath,
              color: Colors.black,
              width: 30,
              height: 30,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                IconData fallbackIcon = Icons.camera_alt;
                if (iconPath.contains('barcode')) fallbackIcon = Icons.qr_code_scanner;
                if (iconPath.contains('gallery')) fallbackIcon = Icons.image;
                return Icon(fallbackIcon, color: Colors.black, size: 30);
              },
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildCategorySection(
      RxList<Map<String, dynamic>> categories,
      bool isExpense,
      ProExpensesIncomeController controller,
      bool isDarkMode,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'selectCategory'.tr,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: categories.map((category) {
            String categoryName = category['name'];
            bool isSelected = isExpense
                ? controller.selectedExpenseCategory.value == categoryName
                : controller.selectedIncomeCategory.value == categoryName;

            return Expanded(
              child: GestureDetector(
                onTap: () {
                  if (isExpense) {
                    controller.selectExpenseCategory(categoryName);
                  } else {
                    controller.selectIncomeCategory(categoryName);
                  }
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.blue : (isDarkMode ? const Color(0xFF2A2A2A) : Colors.grey[200]),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: category['iconPath'] != null
                            ? Image.asset(
                          category['iconPath'],
                          width: 24,
                          height: 24,
                          color: isSelected ? Colors.white : (isDarkMode ? Colors.white : Colors.black),
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              category['icon'] ?? Icons.category,
                              color: isSelected ? Colors.white : (isDarkMode ? Colors.white : Colors.black),
                              size: 24,
                            );
                          },
                        )
                            : Icon(
                          category['icon'] ?? Icons.category,
                          color: isSelected ? Colors.white : (isDarkMode ? Colors.white : Colors.black),
                          size: 24,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        categoryName.tr,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        )),
      ],
    );
  }

  Widget _buildAddCustomCategory(ProExpensesIncomeController controller, bool isDarkMode) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/addCategory');
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF2A2A2A) : Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  'addCustomCategory'.tr,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountSection(ProExpensesIncomeController controller, bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'amount'.tr,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: controller.amountController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          style: GoogleFonts.inter(
            fontSize: 16,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          decoration: InputDecoration(
            hintText: 'enterAmount'.tr,
            hintStyle: TextStyle(color: isDarkMode ? Colors.grey[400] : Colors.grey[600]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: isDarkMode ? Colors.grey[700]! : Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.blue),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            filled: isDarkMode,
            fillColor: isDarkMode ? const Color(0xFF2A2A2A) : Colors.transparent,
          ),
        ),
      ],
    );
  }

  Widget _buildTextBoxSection(ProExpensesIncomeController controller, bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'textBox'.tr,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: controller.descriptionController,
          style: GoogleFonts.inter(
            fontSize: 16,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          decoration: InputDecoration(
            hintText: 'optional'.tr,
            hintStyle: TextStyle(color: isDarkMode ? Colors.grey[400] : Colors.grey[600]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: isDarkMode ? Colors.grey[700]! : Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.blue),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            filled: isDarkMode,
            fillColor: isDarkMode ? const Color(0xFF2A2A2A) : Colors.transparent,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethodSection(ProExpensesIncomeController controller, bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'paymentMethod'.tr,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: controller.paymentMethods.map((method) {
            String methodName = method['name'];
            bool isSelected = controller.selectedPaymentMethod.value == methodName;

            return Expanded(
              child: GestureDetector(
                onTap: () => controller.selectPaymentMethod(methodName),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.blue : (isDarkMode ? const Color(0xFF2A2A2A) : Colors.grey[200]),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: method['iconPath'] != null
                            ? Image.asset(
                          method['iconPath'],
                          width: 24,
                          height: 24,
                          color: isSelected ? Colors.white : (isDarkMode ? Colors.white : Colors.black),
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              method['icon'],
                              color: isSelected ? Colors.white : (isDarkMode ? Colors.white : Colors.black),
                              size: 24,
                            );
                          },
                        )
                            : Icon(
                          method['icon'],
                          color: isSelected ? Colors.white : (isDarkMode ? Colors.white : Colors.black),
                          size: 24,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        methodName.tr,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        )),
      ],
    );
  }

  Widget _buildDateTimeSection(ProExpensesIncomeController controller, bool isDarkMode) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'default'.tr,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    'feb1520241430'.tr,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'setDateTime'.tr,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => _selectDateTime(controller),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: isDarkMode ? const Color(0xFF2A2A2A) : Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      'feb152024'.tr,
                      style: GoogleFonts.inter(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAddButton(ProExpensesIncomeController controller) {
    return SizedBox(
      width: double.infinity,
      child: Obx(() => ElevatedButton(
        onPressed: controller.isLoading.value ? null : controller.addTransaction,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: controller.isLoading.value
            ? const SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        )
            : Text(
          'add'.tr,
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      )),
    );
  }

  void _selectDateTime(ProExpensesIncomeController controller) async {
    final DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: controller.selectedDate.value,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: Get.context!,
        initialTime: controller.selectedTime.value,
      );

      if (pickedTime != null) {
        controller.selectDate(pickedDate);
        controller.selectTime(pickedTime);
      }
    }
  }
}