import 'package:get/get.dart';

class SignupVerificationController extends GetxController {
  var isVerifying = false.obs;
  var isVerificationComplete = false.obs;

  void startVerification() {
    isVerifying.value = true;
    isVerificationComplete.value = false;
  }

  void completeVerification() {
    isVerifying.value = false;
    isVerificationComplete.value = true;
  }
}