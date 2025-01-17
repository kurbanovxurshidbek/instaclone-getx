
import 'package:get/get.dart';
import 'package:instaclone/controllers/signin_controller.dart';
import 'package:instaclone/controllers/signup_controller.dart';
import 'package:instaclone/controllers/splash_controller.dart';

import '../controllers/home_controller.dart';

class RootBinding implements Bindings {
  @override
  void dependencies() {
     Get.lazyPut(() => HomeController(), fenix: true);
     Get.lazyPut(() => SplashController(), fenix: true);
     Get.lazyPut(() => SignInController(), fenix: true);
     Get.lazyPut(() => SignUpController(), fenix: true);
  }
}