import 'package:get/get.dart';
import 'package:texiapptaxi/controllers/auth/auth_controller.dart';
import 'package:texiapptaxi/controllers/login_controller.dart';
import 'package:texiapptaxi/controllers/user_controller.dart';


import 'package:texiapptaxi/core/fetchApi.dart';

class MyBinding implements Bindings {
  @override
  void dependencies() {
    // Get.put(ThemeController());
    
    // Get.put(AuthController());
    Get.put(FetchApi());
    Get.put(UserController());

    // final LoginController _loginController =
    // Get.put(LoginController());
  }
}
