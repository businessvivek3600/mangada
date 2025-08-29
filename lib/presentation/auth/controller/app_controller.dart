

import 'package:get/get.dart';

class AppController extends GetxController {
  static AppController get to => Get.find();
  // Reactive Variables
  final RxString token = ''.obs;
  final RxBool isLoggedIn = false.obs;

  // Save methods
  void saveToken(String newToken) => token.value = newToken;
  void setLoginStatus(bool status) => isLoggedIn.value = status;
}