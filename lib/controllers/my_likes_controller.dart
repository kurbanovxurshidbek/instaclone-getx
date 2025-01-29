
import 'package:get/get.dart';
import 'package:instaclone/services/db_service.dart';

import '../models/post_model.dart';

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

}