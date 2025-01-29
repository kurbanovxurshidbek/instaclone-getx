import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instaclone/models/member_model.dart';
import 'package:instaclone/models/post_model.dart';
import 'package:instaclone/pages/signin_page.dart';
import 'package:instaclone/services/auth_service.dart';
import 'package:instaclone/services/db_service.dart';
import 'package:instaclone/services/file_service.dart';
import 'package:instaclone/services/log_service.dart';
import 'package:instaclone/services/utils_service.dart';

import '../services/prefs_service.dart';

class MyProfileController extends GetxController {
  String? member_image;
  String? member_fullname = "";
  String? member_email = "";

  ImagePicker picker = ImagePicker();

  int count_posts = 0;
  int count_following = 0;
  int count_follower = 0;

  int axisCount = 2;

  List<Post> items = [];

  apiLoadPosts() async {
    var results = await DBService.loadPosts();
    items = results;
    count_posts = items.length;
    update();
  }

  apiLoadMember() async {
    Member member = await DBService.loadMember();

    member_fullname = member.fullname;
    member_email = member.email;
    member_image = member.img_url;
    update();
  }

  void changeAxisCount(int axisCount) {
    this.axisCount = axisCount;
    update();
  }

  void doSignOut(BuildContext context) async {
    var result = await UtilsService.dialogCommon(
        context, "Sign out", "Do you want to sign out?", false);
    LogService.i(result.toString());
    if (result) {
      await AuthService.signOutUser();
      PrefsService.removeUserId();
      Get.off(SignInPage());
    }
  }

  pickFromGallery() async {
    XFile? image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (image != null) {
      var pickedImage = File(image.path);

      String downloadUrl = await FileService.uploadUserImage(pickedImage);
      Member member = await DBService.loadMember();
      member.img_url = downloadUrl;
      await DBService.updateMember(member);
      apiLoadMember();
    }
  }
}
