import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:texiapptaxi/constant/binding.dart';
import 'package:texiapptaxi/constant/theme.dart';

import 'package:texiapptaxi/view/pages/login/login.dart';

import 'package:texiapptaxi/view/pages/setting/setting.dart';
import 'package:texiapptaxi/view/pages/taxihome/taxihome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('ar');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: MyBinding(),
      debugShowCheckedModeBanner: false,
      title: 'Taxi',
      // themeMode: ThemeMode.light,
      themeMode: ThemeMode.dark,
      theme: lightTheme,
      darkTheme: darkTheme,
      // home: ,
      initialRoute: "/login",
      getPages: [
        GetPage(name: '/login', page: () => Login()),
        GetPage(name: '/taxihome', page: () => TaxiHome()),
        GetPage(name: '/setting', page: () => Setting()),
      ],
      // home:Home(),
      // home: ,
    );
  }
}
