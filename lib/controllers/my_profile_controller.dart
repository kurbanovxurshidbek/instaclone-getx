import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:instaclone/models/post_model.dart';
import 'package:instaclone/pages/signin_page.dart';
import 'package:instaclone/services/auth_service.dart';
import 'package:instaclone/services/log_service.dart';
import 'package:instaclone/services/utils_service.dart';

import '../services/prefs_service.dart';

class MyProfileController extends GetxController {
  String? member_image;
  String? member_fullname = "Xurshidbek";
  String? member_email = "xurshidbek@gmail.com";

  int count_posts = 0;
  int count_following = 0;
  int count_follower = 0;

  int axisCount = 2;

  List<Post> items = [];

  addFewPosts() {
    Post post = Post("How to learn flutter faster?",
        "https://images.unsplash.com/photo-1736297150541-89378f055b96?q=80&w=2944&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D");
    post.fullname = "Xurshidbek";
    post.date = "2025.01.20 2PM";
    post.mine = true;
    post.img_user =
        "https://plus.unsplash.com/premium_photo-1664536392896-cd1743f9c02c?q=80&w=3087&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";

    Post post2 = Post("How to learn flutter faster?",
        "https://images.unsplash.com/photo-1542385262-cdf06b302c2c?q=80&w=3087&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D");
    post2.fullname = "Begzodbek";
    post2.mine = false;
    post2.date = "2025.01.01 4PM";

    items.add(post);
    items.add(post2);
    items.add(post);
    items.add(post2);
    items.add(post);
  }

  void changeAxisCount(int axisCount) {
    this.axisCount = axisCount;
    update();
  }

  void doSignOut(BuildContext context) async {
    var result = await UtilsService.dialogCommon(context, "Sign out", "Do you want to sign out?", false);
    LogService.i(result.toString());
    if (result) {
      await AuthService.signOutUser();
      PrefsService.removeUserId();
      Get.off(SignInPage());
    }
  }
}
