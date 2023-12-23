import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:texiapptaxi/controllers/auth/auth_controller.dart';

class MyServices extends GetxService {
  final AuthController authController = Get.put(AuthController());
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  late String? token;
  late String? role;
  late bool isLogedIn = false;

  Future<void> checkToken() async {
    token = await secureStorage.read(key: 'auth_token');
    print("TOKEN : $token");
    if (token != null) {
      isLogedIn = true;
    } else {
      isLogedIn = false;
    }
  }

  Future<MyServices> init() async {
    checkToken();
    // authController.token = await secureStorage.read(key: 'auth_token');
    token = await secureStorage.read(key: 'auth_token');
    print(token);
    print(isLogedIn);
    WidgetsFlutterBinding.ensureInitialized();
    await initializeDateFormatting('ar');

    return this;
  }
}

initialServices() async {
  await Get.putAsync(() => MyServices().init());
}
