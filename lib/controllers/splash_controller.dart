import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instaclone/pages/home_page.dart';
import 'package:instaclone/services/auth_service.dart';

import '../pages/signin_page.dart';

class SplashController extends GetxController {
  callNextPage() {
    if (AuthService.isLoggedIn()) {
      Get.off(HomePage());
    } else {
      Get.off(SignInPage());
    }
  }

  void initTimer() {
    Timer(const Duration(seconds: 2), () {
      callNextPage();
    });
  }
}
