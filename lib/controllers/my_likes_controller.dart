
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:instaclone/services/db_service.dart';

import '../models/post_model.dart';
import '../services/utils_service.dart';

class MyLikesController extends GetxController {
  bool isLoading = false;
  List<Post> items = [];

  apiLoadLikes()async{
    isLoading = true;
    update();

    var results = await DBService.loadLikes();
    items = results;
    isLoading = false;
    update();
  }

  void apiUnlikePost(Post post) async{
    isLoading = true;
    update();

    await DBService.likePost(post, false);

    apiLoadLikes();
  }

  apiRemovePost(Post post) async {
    isLoading = true;
    update();

    await DBService.removePost(post);

    apiLoadLikes();
  }

  void dialogRemovePost(BuildContext context, Post post) async {
    var result = await UtilsService.dialogCommon(
        context, "Remove", "Do you want to remove this post?", false);
    if (result) {
      apiRemovePost(post);
    }
  }

}