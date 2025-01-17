
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instaclone/pages/home_page.dart';

import '../pages/signin_page.dart';

class SplashController extends GetxController {

  callNextPage(){
    Get.off(SignInPage());
  }

  void initTimer() {
    Timer(const Duration(seconds: 2), () {
      callNextPage();
    });
  }

}