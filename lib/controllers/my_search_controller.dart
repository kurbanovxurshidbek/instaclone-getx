import 'package:get/get.dart';
import 'package:instaclone/models/member_model.dart';
import 'package:instaclone/services/db_service.dart';

class MySearchController extends GetxController {
  bool isLoading = false;
  List<Member> items = [];

  apiLoadMembers(String keyword) async {
    isLoading = true;
    update();

    var results = await DBService.searchMembers(keyword);
    items = results;
    isLoading = false;
    update();
  }

  void followMember(Member someone) async {
    isLoading = true;
    update();

    await DBService.followMember(someone);
    someone.followed = true;

    isLoading = false;
    update();

    // Store someone's posts to my feed
    DBService.storePostsToMyFeed(someone);
  }

  void unFollowMember(Member someone) async {
    isLoading = true;
    update();

    await DBService.unFollowMember(someone);
    someone.followed = false;

    isLoading = false;
    update();

    // Remove someone's posts to my feed
    DBService.removePostsToMyFeed(someone);
  }
}
