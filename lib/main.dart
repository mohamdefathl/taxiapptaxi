import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:texiapptaxi/constant/binding.dart';
import 'package:texiapptaxi/constant/theme.dart';
import 'package:texiapptaxi/middleware/supermiddleware.dart';
import 'package:texiapptaxi/services/services.dart';

import 'package:texiapptaxi/view/pages/login/login.dart';

import 'package:texiapptaxi/view/pages/setting/setting.dart';
import 'package:texiapptaxi/view/pages/taxihome/taxihome.dart';

void main() async {
  await initialServices();
  runApp(const MyApp());
}

// Future initalServices ()async{
//   await Get.putAsync(() => MyServices().init());
// }
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: MyBinding(),
      debugShowCheckedModeBanner: false,
      title: 'Taxi',
      themeMode: ThemeMode.dark,
      theme: lightTheme,
      darkTheme: darkTheme,
      // initialRoute: "/",
      getPages: [
        GetPage(name: '/login', page: () => Login()),
        GetPage(
            name: '/', page: () => TaxiHome(), middlewares: [AuthMiddleWare()]),
        GetPage(name: '/setting', page: () => Setting()),
      ],
      // home:Home(),
      // home: ,
    );
  }
}
