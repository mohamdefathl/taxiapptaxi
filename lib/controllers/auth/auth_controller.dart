import 'dart:convert';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:texiapptaxi/core/AppUrl.dart';

class AuthController extends GetxController {
  
  // final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  String ?token ='';
  // String ?token='' ;

  Future<void> setToken(String value)async {
    token = value;
  }
  @override
  void onInit() async {
// token= await secureStorage.read(key: 'token');
    super.onInit();
  }

  Future<Map<String, dynamic>> loginToken(token) async {
    Map<String, dynamic> ?data;

    final url = Uri.parse(AppApiUrl.authWithToken);

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Token $token',
      },
    );
    if (response.statusCode == 200) {
      data = json.decode(utf8.decode(response.bodyBytes));

    }
    return data!;
  }
  
}
