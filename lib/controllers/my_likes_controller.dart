
import 'package:get/get.dart';

import '../models/post_model.dart';

class MyLikesController extends GetxController {
  bool isLoading = false;
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
}