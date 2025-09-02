import 'package:get/get.dart';
import '../routes/app_routes.dart';

class HomeController extends GetxController {
  var selectedNavIndex = 0.obs;
  var starRating = 0.obs;

  var availableBalance = 15000.obs;
  var income = 700.obs;
  var expense = 500.obs;
  var savings = 100.obs;

  var monthlyBudget = 15000.obs;
  var spentAmount = 1400.obs;
  var spentPercentage = 75.obs;
  var leftAmount = 1000.obs;
  var leftPercentage = 15.obs;

  var recentTransactions = <Map<String, dynamic>>[
    {
      'title': 'salary deposit'.tr,
      'time': 'today time'.trParams({'hour': '04', 'minute': '12'}),
      'amount': '3,500.00',
      'isIncome': true
    },
    {
      'title': 'food'.tr,
      'time': 'today time'.trParams({'hour': '04', 'minute': '12'}),
      'amount': '150.00',
      'isIncome': false
    },
    {
      'title': 'shopping'.tr,
      'time': 'today time'.trParams({'hour': '04', 'minute': '12'}),
      'amount': '200.00',
      'isIncome': false
    },
    {
      'title': 'transport'.tr,
      'time': 'today time'.trParams({'hour': '04', 'minute': '12'}),
      'amount': '50.00',
      'isIncome': false
    },
  ].obs;

  String getCurrentMonth() {
    final now = DateTime.now();
    final months = [
      'january'.tr,
      'february'.tr,
      'march'.tr,
      'april'.tr,
      'may'.tr,
      'june'.tr,
      'july'.tr,
      'august'.tr,
      'september'.tr,
      'october'.tr,
      'november'.tr,
      'december'.tr,
    ];
    return months[now.month - 1];
  }

  // Navigation methods
  void navigateToNotification() {
    Get.toNamed(AppRoutes.notification);
  }

  void navigateToMonthlyBudgetnonpro() {
    Get.toNamed(AppRoutes.monthlyBudgetNonPro);
  }

  void navigateToAddTransaction({required bool isExpense}) {
    Get.toNamed(AppRoutes.addTransaction!);
  }

  void navigateToAddProExpense() {
    // Implementation
  }

  void navigateToAddProIncome() {
    // Implementation
  }

  void shareExperience() {
    Get.toNamed(AppRoutes.shareExperience);
  }

  void viewAllTransactions() {
    Get.toNamed(AppRoutes.allTransactions);
  }

  void setStarRating(int rating) {
    starRating.value = rating == starRating.value ? 0 : rating;
  }

  void changeNavIndex(int index) {
    if (selectedNavIndex.value == index) return;

    selectedNavIndex.value = index;

    switch (index) {
      case 0: // Home
        if (Get.currentRoute != AppRoutes.mainHome) {
          Get.offAllNamed(AppRoutes.mainHome);
        }
        break;
      case 1: // Analytics
        Get.toNamed(AppRoutes.analytics);
        break;
      case 2: // Comparison
        Get.toNamed(AppRoutes.comparison);
        break;
      case 3: // Settings
        Get.toNamed(AppRoutes.settings);
        break;
    }
  }

  // Add this method to reset navigation index
  void logout() {
    selectedNavIndex.value = 0; // Reset to home index
    Get.offAllNamed(AppRoutes.login);
  }

  // Add this method to manually set navigation index
  void setNavIndex(int index) {
    selectedNavIndex.value = index;
  }

  void addTransaction(String title, String amount, bool isIncome) {
    final now = DateTime.now();
    final hour = now.hour.toString().padLeft(2, '0');
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.hour >= 12 ? 'pm'.tr : 'am'.tr;

    recentTransactions.insert(0, {
      'title': title,
      'time': 'today_time'.trParams({
        'hour': hour,
        'minute': minute,
        'period': period
      }),
      'amount': amount,
      'isIncome': isIncome,
    });

    if (recentTransactions.length > 4) {
      recentTransactions.removeLast();
    }
  }

  @override
  void onInit() {
    super.onInit();
    selectedNavIndex.value = 0;
  }
}