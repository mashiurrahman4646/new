import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Add validation or API call logic here later
  void login() {
    // Implement login logic (e.g., form validation, API call)
    print('Email: ${emailController.text}, Password: ${passwordController.text}');
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}