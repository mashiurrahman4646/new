import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../routes/app_routes.dart';

class AnalyticsController extends GetxController {
  var selectedChartType = 0.obs; // 0=Pie, 1=Bar, 2=Line

  // Expense and income data with colors matching the Figma design
  final RxList<ChartData> expenseData = <ChartData>[
    ChartData(label: 'House', value: 55, color: const Color(0xFFFF5252)),
    ChartData(label: 'Food', value: 20, color: const Color(0xFF4CAF50)),
    ChartData(label: 'Education', value: 15, color: const Color(0xFF2196F3)),
    ChartData(label: 'Travel', value: 25, color: const Color(0xFF9C27B0)),
  ].obs;

  final RxList<ChartData> incomeData = <ChartData>[
    ChartData(label: 'Job 1', value: 40, color: const Color(0xFF00BCD4)),
    ChartData(label: 'Job 2', value: 60, color: const Color(0xFFFFC107)),
  ].obs;

  List<ChartData> getCombinedChartData() {
    return [
      incomeData[0],
      incomeData[1],
      expenseData[0],
      expenseData[1],
      expenseData[2],
      expenseData[3],
    ];
  }

  List<ChartData> getLineChartData() {
    return [
      ChartData(label: 'Jan', value: 30, color: Colors.transparent),
      ChartData(label: 'Feb', value: 45, color: Colors.transparent),
      ChartData(label: 'Mar', value: 60, color: Colors.transparent),
      ChartData(label: 'Apr', value: 55, color: Colors.transparent),
      ChartData(label: 'May', value: 40, color: Colors.transparent),
      ChartData(label: 'Jun', value: 35, color: Colors.transparent),
    ];
  }

  String getCurrentMonthAndYear() {
    final now = DateTime.now();
    return DateFormat('MMMM, yyyy').format(now);
  }

  void selectChartType(int index) {
    selectedChartType.value = index;
  }

  // Updated method to navigate to the ExpenseListScreen
  void onExpensesClick() {
    print('Expenses clicked');
    Get.toNamed(AppRoutes.expensesScreen);
  }

  // Updated method to navigate to the IncomeListScreen
  void onIncomeClick() {
    print('Income clicked');
    Get.toNamed(AppRoutes.incomeScreen);
  }

  void onExportReportClick() {
    print('Export Report clicked');
    Get.toNamed(AppRoutes.uploadToDrive);
  }

  void navigateToHome() {
    Get.offAllNamed(AppRoutes.mainHome);
  }

  void navigateToComparison() {
    Get.toNamed(AppRoutes.comparison);
  }

  void navigateToSettings() {
    Get.toNamed(AppRoutes.settings);
  }

  // These methods were removed because the routes they call no longer exist.
  // The correct way to add a transaction is via the single `addTransaction` route.

  void navigateToAddProExpense() {

  }

  void navigateToAddProIncome() {

  }

  List<String> get chartTypes => ['Pie Chart', 'Bar Chart', 'Line chart'];

  String get currentChartTypeName => chartTypes[selectedChartType.value];
}

class ChartData {
  final String label;
  final double value;
  final Color color;

  ChartData({required this.label, required this.value, required this.color});
}