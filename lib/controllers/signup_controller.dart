import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instaclone/pages/home_page.dart';
import 'package:instaclone/pages/signin_page.dart';
import 'package:instaclone/services/auth_service.dart';
import 'package:instaclone/services/log_service.dart';
import 'package:instaclone/services/utils_service.dart';

import '../services/prefs_service.dart';

class SignUpController extends GetxController {
  var fullnameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var cpasswordController = TextEditingController();

  bool isLoading = false;

  void callHomePage() {
    Get.off(HomePage());
  }

  void callSignInPage() {
    Get.off(SignInPage());
  }

  void doSignUp(BuildContext context) async {
    String fullname = fullnameController.text.toString().trim();
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    String cpassword = cpasswordController.text.toString().trim();

    if (fullname.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        cpassword.isEmpty) {
      UtilsService.fireToast("Please fill out your information!");
      return;
    }

    if (password != cpassword) {
      UtilsService.fireToast("Your password did not match!");
      return;
    }

    isLoading = true;
    update();

    User? firebaseUser = await AuthService.signUpUser(context, email, password);

    if (firebaseUser != null) {
      PrefsService.saveUserId(firebaseUser.uid);
      callHomePage();
    } else {
      UtilsService.fireToast("Please check your information!");
    }

    isLoading = false;
    update();
  }
}
