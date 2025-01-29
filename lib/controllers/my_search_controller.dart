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
}
