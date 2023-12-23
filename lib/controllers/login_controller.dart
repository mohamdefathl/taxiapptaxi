import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:texiapptaxi/controllers/auth/auth_controller.dart';
import 'package:texiapptaxi/controllers/user_controller.dart';
import 'package:texiapptaxi/core/AppUrl.dart';
import 'package:flutter/material.dart';
import 'package:texiapptaxi/view/widget/general/dialog.dart';

class LoginController extends GetxController {
  final UserController userController = Get.put(UserController());
  final AuthController authController = Get.find<AuthController>();

  final nameText = TextEditingController();
  final passText = TextEditingController();
  @override
  void onClose() {
    nameText.dispose();
    passText.dispose();
    super.onClose();
  }

  void printMessage(String content, String title) {
    dialog(
        hasCancelButton: false,
        title: title,
        content: content,
        confirmOnClick: () {
          Get.back();
        },
        confirmTitle: "اغلاق");
  }

  Future<bool> isConnectedToWifi() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> login() async {
    try {
      final Map<String, String> headers = {'Content-Type': 'application/json'};
      final Map<String, String> body = {'username': 'taxi', 'password': '123'};
      final String requestBody = json.encode(body);

      final http.Response response = await http.post(
        Uri.parse(AppApiUrl.auth),
        headers: headers,
        body: requestBody,
      );

      final int statusCode = response.statusCode;
      final Map<String, dynamic> data = json.decode(response.body);

      if (statusCode >= 200 && statusCode < 300) {
        final token = data['token'];
        final user = data['user'];

        authController.setToken(token);
        userController.setUserData(user);
        authController.setRole(user['role']);
        print(data);
        if (user['role'] == "taxi") {
          // Get.offAllNamed('/taxihome');
          // Get.delete<LoginController>();
        } else {
          throw Exception('Invalid user role');
        }
      } else if (statusCode == 400) {
        throw Exception('Invalid data');
      } else if (statusCode == 401) {
        throw Exception('Unauthorized');
      } else if (statusCode == 404) {
        printMessage(
            'يرجى التاكد من صحة الانترنت والمحاولة مره اخرى', "حدث خطاء ما");
      } else {
        printMessage(
            'يرجى التاكد من صحة الانترنت والمحاولة مره اخرى', "حدث خطاء ما");
      }
    } catch (e) {
      printMessage(
          'يرجى التاكد من صحة الانترنت والمحاولة مره اخرى', "حدث خطاء ما");
    }
  }

  Future<void> loginToken() async {
    try {
      final url = Uri.parse(AppApiUrl.authWithToken);

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Token be0b39d1c793a07158b78fe4f3c6caa6e7e21d30',
        },
        
      );
      final data = json.decode(utf8.decode(response.bodyBytes));
      print(data);
      if (response.statusCode == 200) {
        final data = json.decode(utf8.decode(response.bodyBytes));

        print(data);
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
