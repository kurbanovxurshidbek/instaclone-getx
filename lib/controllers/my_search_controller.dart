import 'package:get/get.dart';
import 'package:instaclone/models/member_model.dart';

class MySearchController extends GetxController {
  bool isLoading = false;
  List<Member> items = [];

  addFakeMembers() {
    Member member1 = Member("Xurshidbek", "xurshidbek@gmail.com");

    member1.img_url =
    "https://plus.unsplash.com/premium_photo-1664536392896-cd1743f9c02c?q=80&w=3087&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";


    Member member2 = Member("Begzodbek", "begzodbek@gmail.com");

    items.add(member1);
    items.add(member2);
    items.add(member1);
    items.add(member2);
    items.add(member1);
    items.add(member2);
    items.add(member1);
    items.add(member2);
    items.add(member1);
    items.add(member2);
    items.add(member1);
    items.add(member2);
    items.add(member1);
    items.add(member2);
  }
}
