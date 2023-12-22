import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:texiapptaxi/constant/color.dart';
import 'package:texiapptaxi/controllers/login_controller.dart';
import 'package:texiapptaxi/view/widget/general/dialog.dart';

import 'package:texiapptaxi/view/widget/login/button.dart';
import 'package:texiapptaxi/view/widget/login/inputFiled.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final LoginController _loginController = Get.put(LoginController());

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      // appBar: AppBar(toolbarHeight: 0),
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              right: 0,
              child: Text(
                "تاكس",
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.grey,fontSize: 10),
                    
              ),
            ),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/images/loginpage.png',
                        width: 350,
                      ),
                      Text(
                        " مرحباً بعودتك تحت امرك",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        "قم بتسجيل دخولك ",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: Colors.grey),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.07,
                      ),
                      MoInput(
                        obscure: false,
                        title: "إسم المستخدم",
                        icon2: Icons.person,
                        nameText: _loginController.nameText,
                        valid: (value) {
                          if (value!.isEmpty) {
                            return "يرجى إدخال اسم المستخدم";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      MoInput(
                        obscure: true,
                        title: "كلمة المرور",
                        icon2: Icons.key,
                        nameText: _loginController.passText,
                        ontap: () {},
                        valid: (value) {
                          if (value!.isEmpty) {
                            return "يرجى إدخال كلمة المرور";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                      // Spacer(),
                      ButtonMo(
                        onTap: () async {
                          if (!_formKey.currentState!.validate()) {
                            bool isConnected =
                                await _loginController.isConnectedToWifi();
                            if (isConnected) {
                              Get.dialog(const Center(
                                child: CircularProgressIndicator(
                                    color: AppColor.primary),
                              ));
                              await _loginController
                                  .login()
                                  .then((_) => Get.back());
                            } else {
                              dialog(
                                  hasCancelButton: false,
                                  title: "لايوجد اتصال بالانترنت",
                                  content:
                                      "يرجى الاتصال بالانترنت والمحاولة مرة اخرى",
                                  confirmTitle: "المتابعة",
                                  confirmOnClick: () {
                                    Get.back();
                                  });
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
