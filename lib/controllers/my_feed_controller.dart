import 'package:get/get.dart';
import 'package:instaclone/services/db_service.dart';

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
}
