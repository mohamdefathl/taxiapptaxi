import 'dart:convert';
import 'dart:developer';
import 'package:texiapptaxi/services/services.dart';
import 'package:get/get.dart';
import 'package:texiapptaxi/controllers/auth/auth_controller.dart';
import 'package:texiapptaxi/core/AppUrl.dart';
import 'package:texiapptaxi/core/stateRequset.dart';
import 'package:texiapptaxi/data/remote/taxi.dart';
import 'package:texiapptaxi/functions/hundlingdata.dart';
import 'package:http/http.dart' as http;

class TaxiOrdersController extends GetxController {
  TaxiOrderPageData orderPageData = TaxiOrderPageData(Get.find());

  final AuthController authController = Get.find<AuthController>();
  MyServices myServices = Get.find();
  @override
  void onInit() async {
    statusRequest = StatusRequest.loading;
    String token = authController.token!;

    await getData(token);

    super.onInit();
  }

  Future getData(String token) async {
    statusRequest = StatusRequest.loading;
    var response = await orderPageData.getData(token);
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      data = response['results'];
    }

    update();
  }

  List data = [];
  String? status;
  late StatusRequest statusRequest;

  // void navigateToDetailPage(OrderModel orderModel) {
  //   Get.to(() => DetailPage(orderModel: orderModel));
  // }

  Future<bool> updateTaxiOrderState(int orderId) async {
    try {
      final response = await http.put(
        Uri.parse("${AppApiUrl.taxiUpdateOrderState}$orderId/"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token ${myServices.token} ',
        },
        body: jsonEncode({"status": "completed"}),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print('Error: $error');
      return false;
    }
  }
}
