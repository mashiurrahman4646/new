import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
 // Import your ThemeController

import '../../Settings/appearance/ThemeController.dart';
import '../../Settings/premium/paymentui.dart';
import '../../make it pro/AdvertisementPage/add_ui.dart';
import '../../routes/app_routes.dart';

class AppColors {
  static const Color text900 = Color(0xFF1E1E1E);
  static const Color text50 = Color(0xFFFAFAFA);
  static const Color primary = Colors.blueAccent;
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color green = Colors.green;
  static const Color orange = Colors.orange;
  static const Color purple = Colors.purple;
  static const Color yellow = Color(0xFFFFD700);
  static const Color expenseButtonIcon = Colors.black;
  static const Color expenseButtonBackground = Colors.yellow;
  static const Color incomeButtonIcon = Colors.black;
  static const Color incomeButtonBackground = Colors.green;
}

class AppStyles {
  static TextStyle sectionHeader(bool isDarkMode) => GoogleFonts.inter(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: isDarkMode ? Colors.white : AppColors.text900,
  );

  static TextStyle buttonText(bool isDarkMode) => GoogleFonts.inter(
    fontSize: 12,
    color: isDarkMode ? Colors.white : AppColors.text900,
  );

  static TextStyle saveButtonText(bool isDarkMode) => GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: isDarkMode ? Colors.white : Colors.black,
  );

  static const EdgeInsets defaultPadding = EdgeInsets.all(16.0);
  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(horizontal: 16, vertical: 12);
  static const EdgeInsets iconPadding = EdgeInsets.all(12);
  static const double defaultRadius = 12.0;
}

class ReceiptButton extends StatelessWidget {
  final String iconPath;
  final String label;
  final Color iconColor;
  final Color backgroundColor;
  final Color borderColor;
  final bool isDarkMode;

  const ReceiptButton({
    super.key,
    required this.iconPath,
    required this.label,
    required this.iconColor,
    required this.backgroundColor,
    required this.borderColor,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
            border: Border.all(color: borderColor, width: 1.5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset(
              iconPath,
              color: iconColor,
              width: 30,
              height: 30,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.error, color: isDarkMode ? Colors.white : Colors.red);
              },
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(label.tr, style: AppStyles.buttonText(isDarkMode)),
      ],
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String iconPath;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isDarkMode;

  const CategoryItem({
    super.key,
    required this.iconPath,
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: AppStyles.iconPadding,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : (isDarkMode ? const Color(0xFF2A2A2A) : AppColors.grey200),
                borderRadius: BorderRadius.circular(AppStyles.defaultRadius),
              ),
              child: Image.asset(
                iconPath,
                color: isSelected ? AppColors.text50 : (isDarkMode ? Colors.white : AppColors.text900),
                width: 24,
                height: 24,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.error, color: isDarkMode ? Colors.white : Colors.red);
                },
              ),
            ),
            const SizedBox(height: 5),
            Text(label.tr, style: AppStyles.buttonText(isDarkMode)),
          ],
        ),
      ),
    );
  }
}

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  int _selectedIndex = 0;
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => DefaultTabController(
      length: 2,
      initialIndex: _selectedIndex,
      child: Scaffold(
        backgroundColor: themeController.isDarkModeActive ? const Color(0xFF121212) : AppColors.text50,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: themeController.isDarkModeActive ? Colors.white : Colors.black),
            onPressed: Get.back,
          ),
          title: Text(
            _selectedIndex == 0 ? 'addExpense'.tr : 'addIncome'.tr,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: themeController.isDarkModeActive ? Colors.white : AppColors.text900,
            ),
          ),
          centerTitle: true,
          backgroundColor: themeController.isDarkModeActive ? const Color(0xFF1E1E1E) : AppColors.text50,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: themeController.isDarkModeActive ? const Color(0xFF2A2A2A) : AppColors.grey200,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: AppColors.primary,
                  ),
                  labelColor: AppColors.text50,
                  unselectedLabelColor: themeController.isDarkModeActive ? Colors.white : AppColors.text900,
                  onTap: (index) => setState(() => _selectedIndex = index),
                  tabs: [
                    Tab(text: 'expense'.tr),
                    Tab(text: 'income'.tr),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            ExpensePage(isDarkMode: themeController.isDarkModeActive),
            IncomePage(isDarkMode: themeController.isDarkModeActive),
          ],
        ),
      ),
    ));
  }
}

class ExpensePage extends StatefulWidget {
  final bool isDarkMode;

  const ExpensePage({super.key, required this.isDarkMode});

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  int _selectedCategoryIndex = 0;
  int _selectedPaymentIndex = 0;
  final ScrollController _categoryController = ScrollController();
  final ScrollController _paymentController = ScrollController();

  @override
  void dispose() {
    _categoryController.dispose();
    _paymentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: AppStyles.defaultPadding,
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('scanOrUploadReceipt'.tr, style: AppStyles.sectionHeader(widget.isDarkMode)),
                const SizedBox(height: 10),
                _buildReceiptButtons(isExpense: true),
                const SizedBox(height: 20),
                _buildCategorySection(),
                const SizedBox(height: 20),
                _buildAddCustomCategory(),
                const SizedBox(height: 20),
                _buildAmountSection(),
                const SizedBox(height: 20),
                _buildPaymentSection(),
                const SizedBox(height: 20),
                _buildDateTimeSection(),
                const SizedBox(height: 20),
                _buildUpgradeButtons(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildReceiptButtons({bool isExpense = false}) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ReceiptButton(
            iconPath: 'assets/icons/cameraoc.png',
            label: 'camera'.tr,
            iconColor: AppColors.expenseButtonIcon,
            backgroundColor: AppColors.expenseButtonBackground,
            borderColor: Colors.black.withOpacity(0.3),
            isDarkMode: widget.isDarkMode,
          ),
          ReceiptButton(
            iconPath: 'assets/icons/barcodescanneroc.png',
            label: 'barcode'.tr,
            iconColor: AppColors.expenseButtonIcon,
            backgroundColor: AppColors.expenseButtonBackground,
            borderColor: Colors.black.withOpacity(0.3),
            isDarkMode: widget.isDarkMode,
          ),
          ReceiptButton(
            iconPath: 'assets/icons/galleryoc.png',
            label: 'gallery'.tr,
            iconColor: AppColors.expenseButtonIcon,
            backgroundColor: AppColors.expenseButtonBackground,
            borderColor: Colors.black.withOpacity(0.3),
            isDarkMode: widget.isDarkMode,
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('selectCategory'.tr, style: AppStyles.sectionHeader(widget.isDarkMode)),
        const SizedBox(height: 10),
        SizedBox(
          height: 100,
          child: ListView(
            controller: _categoryController,
            scrollDirection: Axis.horizontal,
            children: [
              const SizedBox(width: 8),
              CategoryItem(
                iconPath: 'assets/icons/foodoc.png',
                label: 'food'.tr,
                isSelected: _selectedCategoryIndex == 0,
                onTap: () => setState(() => _selectedCategoryIndex = 0),
                isDarkMode: widget.isDarkMode,
              ),
              CategoryItem(
                iconPath: 'assets/icons/transportoc.png',
                label: 'transport'.tr,
                isSelected: _selectedCategoryIndex == 1,
                onTap: () => setState(() => _selectedCategoryIndex = 1),
                isDarkMode: widget.isDarkMode,
              ),
              CategoryItem(
                iconPath: 'assets/icons/Groceriesoc.png',
                label: 'groceries'.tr,
                isSelected: _selectedCategoryIndex == 2,
                onTap: () => setState(() => _selectedCategoryIndex = 2),
                isDarkMode: widget.isDarkMode,
              ),
              CategoryItem(
                iconPath: 'assets/icons/eatingoutoc.png',
                label: 'eatingOut'.tr,
                isSelected: _selectedCategoryIndex == 3,
                onTap: () => setState(() => _selectedCategoryIndex = 3),
                isDarkMode: widget.isDarkMode,
              ),
              CategoryItem(
                iconPath: 'assets/icons/homeoc.png',
                label: 'home'.tr,
                isSelected: _selectedCategoryIndex == 4,
                onTap: () => setState(() => _selectedCategoryIndex = 4),
                isDarkMode: widget.isDarkMode,
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAddCustomCategory() {
    return Container(
      padding: AppStyles.defaultPadding,
      decoration: BoxDecoration(
        color: widget.isDarkMode ? const Color(0xFF2A2A2A) : AppColors.grey200,
        borderRadius: BorderRadius.circular(AppStyles.defaultRadius),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                'addCustomCategory'.tr,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.info_outline, color: widget.isDarkMode ? Colors.grey[400] : AppColors.grey500, size: 16),
              const SizedBox(width: 5),
              Flexible(
                child: Text(
                  'proFeatureOnly'.tr,
                  style: GoogleFonts.inter(
                    color: widget.isDarkMode ? Colors.grey[400] : AppColors.grey500,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAmountSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('amount'.tr, style: AppStyles.sectionHeader(widget.isDarkMode)),
        const SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(
            hintText: 'enterAmount'.tr,
            hintStyle: GoogleFonts.inter(color: widget.isDarkMode ? Colors.grey[400] : AppColors.grey500),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppStyles.defaultRadius),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppStyles.defaultRadius),
              borderSide: BorderSide(color: widget.isDarkMode ? const Color(0xFF444444) : AppColors.grey200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppStyles.defaultRadius),
              borderSide: const BorderSide(color: AppColors.primary),
            ),
            contentPadding: AppStyles.buttonPadding,
            filled: widget.isDarkMode,
            fillColor: widget.isDarkMode ? const Color(0xFF2A2A2A) : Colors.transparent,
          ),
          style: GoogleFonts.inter(color: widget.isDarkMode ? Colors.white : Colors.black),
        ),
      ],
    );
  }

  Widget _buildPaymentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('paymentMethod'.tr, style: AppStyles.sectionHeader(widget.isDarkMode)),
        const SizedBox(height: 10),
        SizedBox(
          height: 100,
          child: ListView(
            controller: _paymentController,
            scrollDirection: Axis.horizontal,
            children: [
              const SizedBox(width: 8),
              CategoryItem(
                iconPath: 'assets/icons/cashoc.png',
                label: 'cash'.tr,
                isSelected: _selectedPaymentIndex == 0,
                onTap: () => setState(() => _selectedPaymentIndex = 0),
                isDarkMode: widget.isDarkMode,
              ),
              const SizedBox(width: 20),
              CategoryItem(
                iconPath: 'assets/icons/mobileoc.png',
                label: 'mobile'.tr,
                isSelected: _selectedPaymentIndex == 1,
                onTap: () => setState(() => _selectedPaymentIndex = 1),
                isDarkMode: widget.isDarkMode,
              ),
              const SizedBox(width: 20),
              CategoryItem(
                iconPath: 'assets/icons/Group 9.png',
                label: 'bank'.tr,
                isSelected: _selectedPaymentIndex == 2,
                onTap: () => setState(() => _selectedPaymentIndex = 2),
                isDarkMode: widget.isDarkMode,
              ),
              const SizedBox(width: 20),
              CategoryItem(
                iconPath: 'assets/icons/cardoc.png',
                label: 'card'.tr,
                isSelected: _selectedPaymentIndex == 3,
                onTap: () => setState(() => _selectedPaymentIndex = 3),
                isDarkMode: widget.isDarkMode,
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDateTimeSection() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'default'.tr,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: widget.isDarkMode ? Colors.white : AppColors.text900,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: AppStyles.buttonPadding,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(AppStyles.defaultRadius),
                ),
                child: Center(
                  child: Text(
                    'feb1520241430'.tr,
                    style: GoogleFonts.inter(
                      color: AppColors.text50,
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
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'setDateTime'.tr,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: widget.isDarkMode ? Colors.white : AppColors.text900,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: AppStyles.buttonPadding,
                decoration: BoxDecoration(
                  color: widget.isDarkMode ? const Color(0xFF2A2A2A) : AppColors.grey200,
                  borderRadius: BorderRadius.circular(AppStyles.defaultRadius),
                ),
                child: Center(
                  child: Text(
                    'feb152024'.tr,
                    style: GoogleFonts.inter(
                      color: widget.isDarkMode ? Colors.white : AppColors.text900,
                      fontSize: 12,
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

  Widget _buildUpgradeButtons() {
    return Column(
      children: [
        _buildUpgradeButton(
          icon: Icons.play_circle_outline,
          text: 'watchVideoForFree'.tr,
          color: AppColors.primary.withOpacity(0.1),
          borderColor: AppColors.primary,
        ),
        const SizedBox(height: 10),
        _buildUpgradeButton(
          icon: Icons.check_circle_outline,
          text: 'upgradeToPro'.tr,
          color: widget.isDarkMode ? const Color(0xFF2A2A2A) : AppColors.grey200,
          borderColor: widget.isDarkMode ? Colors.grey[600]! : AppColors.grey500,
        ),
      ],
    );
  }

  Widget _buildUpgradeButton({
    required IconData icon,
    required String text,
    required Color color,
    required Color borderColor,
  }) {
    return GestureDetector(
      onTap: () async {
        if (text.contains('watchVideoForFree'.tr)) {
          final result = await Get.to<bool>(
                () => AdvertisementPage(isFromExpense: true),
            routeName: AppRoutes.advertisement,
          );

          if (result == true) {
            Get.offNamed(
              AppRoutes.proExpensesIncome,
              arguments: {'defaultTab': 0},
            );
          }
        } else if (text.contains('upgradeToPro'.tr)) {
          Get.to(() => PremiumPlansScreen());
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(AppStyles.defaultRadius),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                color: borderColor == AppColors.primary
                    ? AppColors.primary
                    : (widget.isDarkMode ? Colors.white : AppColors.text900)),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                text,
                style: GoogleFonts.inter(
                  color: borderColor == AppColors.primary
                      ? AppColors.primary
                      : (widget.isDarkMode ? Colors.white : AppColors.text900),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IncomePage extends StatefulWidget {
  final bool isDarkMode;

  const IncomePage({super.key, required this.isDarkMode});

  @override
  State<IncomePage> createState() => _IncomePageState();
}

class _IncomePageState extends State<IncomePage> {
  int _selectedCategoryIndex = 0;
  int _selectedPaymentIndex = 0;
  final ScrollController _categoryController = ScrollController();
  final ScrollController _paymentController = ScrollController();

  @override
  void dispose() {
    _categoryController.dispose();
    _paymentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: AppStyles.defaultPadding,
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('scanOrUploadReceipt'.tr, style: AppStyles.sectionHeader(widget.isDarkMode)),
                const SizedBox(height: 10),
                _buildReceiptButtons(),
                const SizedBox(height: 20),
                _buildCategorySection(),
                const SizedBox(height: 20),
                _buildAddCustomCategory(),
                const SizedBox(height: 20),
                _buildAmountSection(),
                const SizedBox(height: 20),
                _buildPaymentSection(),
                const SizedBox(height: 20),
                _buildDateTimeSection(),
                const SizedBox(height: 20),
                _buildUpgradeButtons(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildReceiptButtons() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ReceiptButton(
            iconPath: 'assets/icons/cameraoc.png',
            label: 'camera'.tr,
            iconColor: AppColors.incomeButtonIcon,
            backgroundColor: AppColors.incomeButtonBackground,
            borderColor: Colors.black.withOpacity(0.3),
            isDarkMode: widget.isDarkMode,
          ),
          ReceiptButton(
            iconPath: 'assets/icons/barcodescanneroc.png',
            label: 'barcode'.tr,
            iconColor: AppColors.incomeButtonIcon,
            backgroundColor: AppColors.incomeButtonBackground,
            borderColor: Colors.black.withOpacity(0.3),
            isDarkMode: widget.isDarkMode,
          ),
          ReceiptButton(
            iconPath: 'assets/icons/galleryoc.png',
            label: 'gallery'.tr,
            iconColor: AppColors.incomeButtonIcon,
            backgroundColor: AppColors.incomeButtonBackground,
            borderColor: Colors.black.withOpacity(0.3),
            isDarkMode: widget.isDarkMode,
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('selectCategory'.tr, style: AppStyles.sectionHeader(widget.isDarkMode)),
        const SizedBox(height: 10),
        SizedBox(
          height: 100,
          child: ListView(
            controller: _categoryController,
            scrollDirection: Axis.horizontal,
            children: [
              const SizedBox(width: 8),
              CategoryItem(
                iconPath: 'assets/icons/foodoc.png',
                label: 'food'.tr,
                isSelected: _selectedCategoryIndex == 0,
                onTap: () => setState(() => _selectedCategoryIndex = 0),
                isDarkMode: widget.isDarkMode,
              ),
              CategoryItem(
                iconPath: 'assets/icons/transportoc.png',
                label: 'transport'.tr,
                isSelected: _selectedCategoryIndex == 1,
                onTap: () => setState(() => _selectedCategoryIndex = 1),
                isDarkMode: widget.isDarkMode,
              ),
              CategoryItem(
                iconPath: 'assets/icons/Groceriesoc.png',
                label: 'groceries'.tr,
                isSelected: _selectedCategoryIndex == 2,
                onTap: () => setState(() => _selectedCategoryIndex = 2),
                isDarkMode: widget.isDarkMode,
              ),
              CategoryItem(
                iconPath: 'assets/icons/eatingoutoc.png',
                label: 'eatingOut'.tr,
                isSelected: _selectedCategoryIndex == 3,
                onTap: () => setState(() => _selectedCategoryIndex = 3),
                isDarkMode: widget.isDarkMode,
              ),
              CategoryItem(
                iconPath: 'assets/icons/homeoc.png',
                label: 'home'.tr,
                isSelected: _selectedCategoryIndex == 4,
                onTap: () => setState(() => _selectedCategoryIndex = 4),
                isDarkMode: widget.isDarkMode,
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAddCustomCategory() {
    return Container(
      padding: AppStyles.defaultPadding,
      decoration: BoxDecoration(
        color: widget.isDarkMode ? const Color(0xFF2A2A2A) : AppColors.grey200,
        borderRadius: BorderRadius.circular(AppStyles.defaultRadius),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                'addCustomCategory'.tr,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.info_outline, color: widget.isDarkMode ? Colors.grey[400] : AppColors.grey500, size: 16),
              const SizedBox(width: 5),
              Flexible(
                child: Text(
                  'proFeatureOnly'.tr,
                  style: GoogleFonts.inter(
                    color: widget.isDarkMode ? Colors.grey[400] : AppColors.grey500,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAmountSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('amount'.tr, style: AppStyles.sectionHeader(widget.isDarkMode)),
        const SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(
            hintText: 'enterAmount'.tr,
            hintStyle: GoogleFonts.inter(color: widget.isDarkMode ? Colors.grey[400] : AppColors.grey500),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppStyles.defaultRadius),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppStyles.defaultRadius),
              borderSide: BorderSide(color: widget.isDarkMode ? const Color(0xFF444444) : AppColors.grey200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppStyles.defaultRadius),
              borderSide: const BorderSide(color: AppColors.primary),
            ),
            contentPadding: AppStyles.buttonPadding,
            filled: widget.isDarkMode,
            fillColor: widget.isDarkMode ? const Color(0xFF2A2A2A) : Colors.transparent,
          ),
          style: GoogleFonts.inter(color: widget.isDarkMode ? Colors.white : Colors.black),
        ),
      ],
    );
  }

  Widget _buildPaymentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('paymentMethod'.tr, style: AppStyles.sectionHeader(widget.isDarkMode)),
        const SizedBox(height: 10),
        SizedBox(
          height: 100,
          child: ListView(
            controller: _paymentController,
            scrollDirection: Axis.horizontal,
            children: [
              const SizedBox(width: 8),
              CategoryItem(
                iconPath: 'assets/icons/cashoc.png',
                label: 'cash'.tr,
                isSelected: _selectedPaymentIndex == 0,
                onTap: () => setState(() => _selectedPaymentIndex = 0),
                isDarkMode: widget.isDarkMode,
              ),
              const SizedBox(width: 20),
              CategoryItem(
                iconPath: 'assets/icons/mobileoc.png',
                label: 'mobile'.tr,
                isSelected: _selectedPaymentIndex == 1,
                onTap: () => setState(() => _selectedPaymentIndex = 1),
                isDarkMode: widget.isDarkMode,
              ),
              const SizedBox(width: 20),
              CategoryItem(
                iconPath: 'assets/icons/bankoc.png',
                label: 'bank'.tr,
                isSelected: _selectedPaymentIndex == 2,
                onTap: () => setState(() => _selectedPaymentIndex = 2),
                isDarkMode: widget.isDarkMode,
              ),
              const SizedBox(width: 20),
              CategoryItem(
                iconPath: 'assets/icons/cardoc.png',
                label: 'card'.tr,
                isSelected: _selectedPaymentIndex == 3,
                onTap: () => setState(() => _selectedPaymentIndex = 3),
                isDarkMode: widget.isDarkMode,
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDateTimeSection() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'default'.tr,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: widget.isDarkMode ? Colors.white : AppColors.text900,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: AppStyles.buttonPadding,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(AppStyles.defaultRadius),
                ),
                child: Center(
                  child: Text(
                    'feb1520241430'.tr,
                    style: GoogleFonts.inter(
                      color: AppColors.text50,
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
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'setDateTime'.tr,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: widget.isDarkMode ? Colors.white : AppColors.text900,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: AppStyles.buttonPadding,
                decoration: BoxDecoration(
                  color: widget.isDarkMode ? const Color(0xFF2A2A2A) : AppColors.grey200,
                  borderRadius: BorderRadius.circular(AppStyles.defaultRadius),
                ),
                child: Center(
                  child: Text(
                    'feb152024'.tr,
                    style: GoogleFonts.inter(
                      color: widget.isDarkMode ? Colors.white : AppColors.text900,
                      fontSize: 12,
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

  Widget _buildUpgradeButtons() {
    return Column(
      children: [
        _buildUpgradeButton(
          icon: Icons.play_circle_outline,
          text: 'watchVideoForFree'.tr,
          color: AppColors.primary.withOpacity(0.1),
          borderColor: AppColors.primary,
        ),
        const SizedBox(height: 10),
        _buildUpgradeButton(
          icon: Icons.check_circle_outline,
          text: 'upgradeToPro'.tr,
          color: widget.isDarkMode ? const Color(0xFF2A2A2A) : AppColors.grey200,
          borderColor: widget.isDarkMode ? Colors.grey[600]! : AppColors.grey500,
        ),
      ],
    );
  }

  Widget _buildUpgradeButton({
    required IconData icon,
    required String text,
    required Color color,
    required Color borderColor,
  }) {
    return GestureDetector(
      onTap: () async {
        if (text.contains('watchVideoForFree'.tr)) {
          final result = await Get.to<bool>(
                () => AdvertisementPage(isFromExpense: false),
            routeName: AppRoutes.advertisement,
          );

          if (result == true) {
            Get.offNamed(
              AppRoutes.proExpensesIncome,
              arguments: {'defaultTab': 1},
            );
          }
        } else if (text.contains('upgradeToPro'.tr)) {
          Get.to(() => PremiumPlansScreen());
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(AppStyles.defaultRadius),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                color: borderColor == AppColors.primary
                    ? AppColors.primary
                    : (widget.isDarkMode ? Colors.white : AppColors.text900)),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                text,
                style: GoogleFonts.inter(
                  color: borderColor == AppColors.primary
                      ? AppColors.primary
                      : (widget.isDarkMode ? Colors.white : AppColors.text900),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}