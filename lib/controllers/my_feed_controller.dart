import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:instaclone/services/db_service.dart';
import 'package:instaclone/services/utils_service.dart';

import '../models/post_model.dart';

class MyFeedController extends GetxController {
  bool isLoading = false;
  List<Post> items = [];

  apiLoadMyFeed() async {
    isLoading = true;
    update();

    var results = await DBService.loadFeeds();
    items = results;
    isLoading = false;
    update();
  }

  apiLikePost(Post post) async {
    isLoading = true;
    update();

    await DBService.likePost(post, true);

    post.liked = true;
    isLoading = false;
    update();
  }

  apiUnlikePost(Post post) async {
    isLoading = true;
    update();

    await DBService.likePost(post, false);

    post.liked = false;
    isLoading = false;
    update();
  }

  apiRemovePost(Post post) async {
    isLoading = true;
    update();

    await DBService.removePost(post);

    apiLoadMyFeed();
  }

  void dialogRemovePost(BuildContext context, Post post) async {
    var result = await UtilsService.dialogCommon(
        context, "Remove", "Do you want to remove this post?", false);
    if (result) {
      apiRemovePost(post);
    }
  }
}
