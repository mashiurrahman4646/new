import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';

class UploadToDriveController extends GetxController {
  // Export Data Options
  var allFiles = true.obs;
  var monthlyReports = false.obs;
  var incomeReports = false.obs;
  var expenseReports = false.obs;
  var savingsReports = false.obs;

  // File Format
  var selectedFormat = 'PDF'.obs;

  // Auto Upload
  var autoUpload = true.obs;

  // Dialog State
  var showSuccessDialog = false.obs;

  // Toggle functions for export data
  void toggleAllFiles() {
    allFiles.value = !allFiles.value;
    // If all files is selected, unselect others
    if (allFiles.value) {
      monthlyReports.value = false;
      incomeReports.value = false;
      expenseReports.value = false;
      savingsReports.value = false;
    }
  }

  void toggleMonthlyReports() {
    monthlyReports.value = !monthlyReports.value;
    if (monthlyReports.value) {
      allFiles.value = false;
    }
  }

  void toggleIncomeReports() {
    incomeReports.value = !incomeReports.value;
    if (incomeReports.value) {
      allFiles.value = false;
    }
  }

  void toggleExpenseReports() {
    expenseReports.value = !expenseReports.value;
    if (expenseReports.value) {
      allFiles.value = false;
    }
  }

  void toggleSavingsReports() {
    savingsReports.value = !savingsReports.value;
    if (savingsReports.value) {
      allFiles.value = false;
    }
  }

  // File format selection
  void selectFormat(String format) {
    selectedFormat.value = format;
  }

  // Auto upload toggle
  void toggleAutoUpload(bool value) {
    autoUpload.value = value;
  }

  // Download button click
  void onDownloadClick() {
    print('Download clicked');
    Get.snackbar(
      'Download',
      'Download Successful',
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 2),
      icon: Icon(Icons.download, color: Colors.white),
    );
  }

  // Upload to drive button click
  void onUploadToDriveClick() {
    print('Upload to Drive clicked');
    showSuccessDialog.value = true;
  }

  // Close dialog and navigate to analytics
  void closeDialogAndNavigateToAnalytics() {
    showSuccessDialog.value = false;
    // Navigate to analytics screen
    Get.offNamedUntil(AppRoutes.analytics, (route) => false);
  }

  // Get selected export options as string
  String getSelectedExportOptions() {
    List<String> selected = [];
    if (allFiles.value) selected.add('All files');
    if (monthlyReports.value) selected.add('Monthly reports');
    if (incomeReports.value) selected.add('Income reports');
    if (expenseReports.value) selected.add('Expense reports');
    if (savingsReports.value) selected.add('Savings reports');
    return selected.join(', ');
  }

  @override
  void onInit() {
    super.onInit();
    print('Upload to Drive Controller initialized');
  }

  @override
  void onClose() {
    super.onClose();
    print('Upload to Drive Controller disposed');
  }
}