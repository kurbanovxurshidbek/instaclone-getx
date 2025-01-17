import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  PageController pageController = PageController();

  int currentTap = 0;

  void onPageChanged(int index) {
    currentTap = index;
    update();
  }

  void onTap(int index) {
    currentTap = index;
    update();
  }
}
