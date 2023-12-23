import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:texiapptaxi/controllers/auth/auth_controller.dart';
import 'package:texiapptaxi/controllers/user_controller.dart';
import 'package:texiapptaxi/core/AppUrl.dart';
import 'package:flutter/material.dart';
import 'package:texiapptaxi/core/stateRequset.dart';
import 'package:texiapptaxi/services/services.dart';
import 'package:texiapptaxi/view/widget/general/dialog.dart';

class LoginController extends GetxController {
  final UserController userController = Get.put(UserController());
  // final AuthController authController = Get.find<AuthController>();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  MyServices myServices = Get.find();
  late StatusRequest statusRequest;
  final nameText = TextEditingController();
  final passText = TextEditingController();
  @override
  void onClose() {
    // nameText.dispose();
    // passText.dispose();
    super.onClose();
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

  // login() async {
  //   if (formKey.currentState!.validate()) {
  //     statusRequest = StatusRequest.loading;
  //     update();
  //     var response = await loginData.postData(
  //         userName: userNameController.text, password: passwordController.text);
  //     statusRequest = handlingData(response);
  //     if (statusRequest == StatusRequest.success) {
  //       userModel = UserModel.fromJson(response);
  //       if (response['user']['role'] == 'customer') {
  //         myServices.isLogedIn = true;
  //         await myServices.secureStorage
  //             .write(key: 'token', value: response['token']);

  //         Get.toNamed("/");
  //       } else {
  //         // print('admin');
  //       }
  //     } else {
  //       Get.defaultDialog(
  //           title: 'Warning', middleText: 'Wrong password or username');
  //     }

  //     update();
  //   }
  // }
  Future<void> login() async {
    try {
      final Map<String, String> headers = {'Content-Type': 'application/json'};
      final Map<String, String> body = {
        'username': 'mosmosmos',
        'password': 'samQAZ123'
      };
      final String requestBody = json.encode(body);

      final http.Response response = await http.post(
        Uri.parse(AppApiUrl.auth),
        headers: headers,
        body: requestBody,
      );

      final int statusCode = response.statusCode;
      final Map<String, dynamic> data = json.decode(response.body);

      if (statusCode >= 200 && statusCode < 300) {
        final user = data['user'];
        userController.setUserData(user);

        if (user['role'] == "taxi") {
          await secureStorage
              .write(key: 'auth_token', value: data['token']);
          myServices.isLogedIn = true;
          myServices.token=data['token'];
                    

          Get.toNamed('/');
          Get.delete<LoginController>();          
        } else {
          Get.back();
          printMessage("يرجى التاكد من صحة البيانات", "حدث خطاء ");
        }
      } else if (statusCode == 400) {
        // throw Exception('Invalid data');
        Get.back();
        printMessage("يرجى التاكد من صحة البيانات", "حدث خطاء ");
      } else if (statusCode == 401) {
        Get.back();
        throw Exception('Unauthorized');
      } else if (statusCode == 404) {
        // print("404 $statusCode");
        Get.back();
        throw Exception('User not found');
      } else {
        print("000 $statusCode");
        Get.back();
        throw Exception('Unknown error occurred');
      }
    } catch (e) {
      Get.back();
      printMessage(
          'يرجى التاكد من صحة الانترنت والمحاولة مره اخرى', "حدث خطاء ما");
    }
  }
}
