import 'package:get/get.dart';
import 'package:instaclone/controllers/my_feed_controller.dart';
import 'package:instaclone/controllers/my_likes_controller.dart';
import 'package:instaclone/controllers/my_profile_controller.dart';
import 'package:instaclone/controllers/my_search_controller.dart';
import 'package:instaclone/controllers/my_upload_controller.dart';
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
    Get.lazyPut(() => MyUploadController(), fenix: true);
    Get.lazyPut(() => MyFeedController(), fenix: true);
    Get.lazyPut(() => MyLikesController(), fenix: true);
    Get.lazyPut(() => MySearchController(), fenix: true);
    Get.lazyPut(() => MyProfileController(), fenix: true);
  }
}
