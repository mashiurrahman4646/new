import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:your_expense/tram_and_condition/trams_condition_controller.dart';
import 'Settings/appearance/ThemeController.dart';
import 'Settings/language/language_controller.dart';
import 'add_exp/pro_user/expenseincomepro/proexpincome_controller.dart';
import 'config/app_config.dart';
import 'homepage/main_home_page_controller.dart';
// Make sure this import is correct

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize controllers first
  final themeController = Get.put(ThemeController(), permanent: true);
  final langController = Get.put(LanguageController(), permanent: true);

  // Load settings before running app
  await themeController.loadTheme();
  await langController.loadLanguage();

  // Other controllers
  Get.put<HomeController>(HomeController(), permanent: true);
  Get.put<ProExpensesIncomeController>(ProExpensesIncomeController(), permanent: true);
  Get.put<TermsAndConditionsController>(TermsAndConditionsController(), permanent: true);

  runApp(AppConfig.app);
}