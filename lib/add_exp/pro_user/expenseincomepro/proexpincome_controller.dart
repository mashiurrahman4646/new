import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class ProExpensesIncomeController extends GetxController {
  // Form Controllers
  late final TextEditingController amountController;
  late final TextEditingController descriptionController;

  // Observable variables
  var currentTab = 0.obs;
  var initialTab = 0;
  var selectedExpenseCategory = ''.obs;
  var selectedIncomeCategory = ''.obs;
  var selectedPaymentMethod = ''.obs;
  var selectedDate = DateTime.now().obs;
  var selectedTime = TimeOfDay.now().obs;
  var isLoading = false.obs;
  var uploadedReceiptPath = ''.obs;

  // Pro feature unlocks
  var isExpenseProUnlocked = false.obs;
  var isIncomeProUnlocked = false.obs;

  // Categories
  final expenseCategories = <Map<String, dynamic>>[
    {'name': 'food', 'icon': Icons.restaurant},
    {'name': 'transport', 'icon': Icons.directions_car},
    {'name': 'groceries', 'icon': Icons.shopping_cart},
    {'name': 'eatingOut', 'icon': Icons.fastfood},
    {'name': 'home', 'icon': Icons.home},
  ].obs;

  final incomeCategories = <Map<String, dynamic>>[
    {'name': 'salary', 'icon': Icons.account_balance_wallet},
    {'name': 'freelance', 'icon': Icons.work},
    {'name': 'donation', 'icon': Icons.volunteer_activism},
    {'name': 'overtime', 'icon': Icons.access_time},
    {'name': 'gift', 'icon': Icons.card_giftcard},
  ].obs;

  final paymentMethods = <Map<String, dynamic>>[
    {'name': 'cash', 'icon': Icons.money},
    {'name': 'mobile', 'icon': Icons.phone_android},
    {'name': 'bank', 'icon': Icons.account_balance},
    {'name': 'card', 'icon': Icons.credit_card},
  ].obs;

  @override
  void onInit() {
    super.onInit();
    _initializeControllers();
    _loadUnlockStatus();

    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null && args.containsKey('defaultTab')) {
      initialTab = args['defaultTab'] ?? 0;
      currentTab.value = initialTab;
    }
  }

  void _initializeControllers() {
    amountController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void onClose() {
    amountController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  Future<void> _loadUnlockStatus() async {
    final prefs = await SharedPreferences.getInstance();
    isExpenseProUnlocked.value = prefs.getBool('isExpenseProUnlocked') ?? false;
    isIncomeProUnlocked.value = prefs.getBool('isIncomeProUnlocked') ?? false;
  }

  Future<void> unlockProFeatures(bool isExpense) async {
    final prefs = await SharedPreferences.getInstance();
    // Unlock both features when watching ad
    isExpenseProUnlocked.value = true;
    isIncomeProUnlocked.value = true;
    await prefs.setBool('isExpenseProUnlocked', true);
    await prefs.setBool('isIncomeProUnlocked', true);
  }

  void switchToTab(int tab) {
    currentTab.value = tab;
    clearSelections();
  }

  void selectExpenseCategory(String category) {
    selectedExpenseCategory.value = category;
  }

  void selectIncomeCategory(String category) {
    selectedIncomeCategory.value = category;
  }

  void selectPaymentMethod(String method) {
    selectedPaymentMethod.value = method;
  }

  void selectDate(DateTime date) {
    selectedDate.value = date;
  }

  void selectTime(TimeOfDay time) {
    selectedTime.value = time;
  }

  void clearSelections() {
    selectedExpenseCategory.value = '';
    selectedIncomeCategory.value = '';
    selectedPaymentMethod.value = '';
  }

  Future<void> handleReceiptAction(String action) async {
    try {
      switch (action) {
        case 'camera':
          await _captureFromCamera();
          break;
        case 'scanner':
          await _scanReceipt();
          break;
        case 'gallery':
          await _pickFromGallery();
          break;
      }
    } catch (e) {
      Get.snackbar('error'.tr, '${'receiptError'.tr}: $e');
    }
  }

  Future<void> _captureFromCamera() async {
    Get.snackbar('info'.tr, 'cameraFeature'.tr);
  }

  Future<void> _scanReceipt() async {
    Get.snackbar('info'.tr, 'scannerFeature'.tr);
  }

  Future<void> _pickFromGallery() async {
    Get.snackbar('info'.tr, 'galleryFeature'.tr);
  }

  String getFormattedDateTime() {
    final date = selectedDate.value;
    final time = selectedTime.value;
    return '${_getMonthAbbreviation(date.month)} ${date.day}, ${date.year} - ${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  String getFormattedDate() {
    final date = selectedDate.value;
    return '${_getMonthAbbreviation(date.month)} ${date.day}, ${date.year}';
  }

  String _getMonthAbbreviation(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }

  void addCustomCategory(String name, IconData icon, bool isExpense) {
    final newCategory = {'name': name, 'icon': icon};
    if (isExpense) {
      expenseCategories.add(newCategory);
      selectExpenseCategory(name);
    } else {
      incomeCategories.add(newCategory);
      selectIncomeCategory(name);
    }
  }

  Future<void> addTransaction() async {
    if (!validateForm()) return;

    isLoading.value = true;

    try {
      bool isExpense = currentTab.value == 0;
      String selectedCategory = isExpense
          ? selectedExpenseCategory.value
          : selectedIncomeCategory.value;

      Map<String, dynamic> transaction = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'type': isExpense ? 'expense' : 'income',
        'amount': double.parse(amountController.text),
        'category': selectedCategory,
        'paymentMethod': selectedPaymentMethod.value,
        'description': descriptionController.text.trim(),
        'date': selectedDate.value,
        'time': selectedTime.value,
        'receiptPath': uploadedReceiptPath.value,
      };

      Get.snackbar(
        'success'.tr,
        'transactionSuccess'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );

      clearForm();
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        '${'transactionError'.tr}: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  bool validateForm() {
    if (amountController.text.isEmpty) {
      Get.snackbar('error'.tr, 'enterAmountError'.tr);
      return false;
    }

    if (currentTab.value == 0 && selectedExpenseCategory.isEmpty) {
      Get.snackbar('error'.tr, 'selectExpenseCategoryError'.tr);
      return false;
    }

    if (currentTab.value == 1 && selectedIncomeCategory.isEmpty) {
      Get.snackbar('error'.tr, 'selectIncomeCategoryError'.tr);
      return false;
    }

    if (selectedPaymentMethod.isEmpty) {
      Get.snackbar('error'.tr, 'selectPaymentMethodError'.tr);
      return false;
    }

    return true;
  }

  void clearForm() {
    amountController.clear();
    descriptionController.clear();
    uploadedReceiptPath.value = '';
    clearSelections();
  }
}