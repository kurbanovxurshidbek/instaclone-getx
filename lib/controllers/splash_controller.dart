import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instaclone/pages/home_page.dart';
import 'package:instaclone/services/auth_service.dart';
import 'package:instaclone/services/prefs_service.dart';
import 'package:instaclone/services/utils_service.dart';

import '../pages/signin_page.dart';
import '../services/log_service.dart';
import '../services/notif_service.dart';

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

  void loadDeviceParams()async{
    var result = await UtilsService.deviceUniqueId();
    LogService.i(result.toString());
  }

  void initNotification() async {
    final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      LogService.i('User granted permission');
    } else {
      LogService.e('User declined or has not accepted permission');
    }

    firebaseMessaging.getToken().then((value) async {
      String fcmToken = value.toString();
      PrefsService.saveFCMToken(fcmToken);
      String token = await PrefsService.loadFCMToken();
      LogService.i("FCM Token: $token");
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      String title = message.notification!.title.toString();
      String body = message.notification!.body.toString();
      LogService.i(title);
      LogService.i(body);
      NotifService().showLocalNotification(title, body);
    });
  }
}
