import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarview_app/constants/themes/textstyles.dart';

import '../constants/assets.dart';
import '../constants/strings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () async {
      Get.offNamed('/home-page');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                appIcon,
                width: Get.width / 2,
              ),
              const SizedBox(height: 15),
              Text(
                smartViewT,
                style: textstyle.copyWith(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  letterSpacing: .5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
