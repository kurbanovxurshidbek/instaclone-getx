import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instaclone/services/auth_service.dart';
import 'package:instaclone/services/log_service.dart';
import 'package:instaclone/services/utils_service.dart';

import '../models/member_model.dart';
import '../models/post_model.dart';

class DBService {
  static final _firestore = FirebaseFirestore.instance;

  static String folder_users = "users";
  static String folder_posts = "posts";

  /// Member Related
  static Future storeMember(Member member) async {
    member.uid = AuthService.currentUserId();

    return _firestore
        .collection(folder_users)
        .doc(member.uid)
        .set(member.toJson());
  }

  static Future loadMember() async {
    String uid = AuthService.currentUserId();
    var value = await _firestore.collection(folder_users).doc(uid).get();
    Member member = Member.fromJson(value.data()!);

    return member;
  }

  /// Post Related
  static Future<Post> storePost(Post post) async {
    
    Member member = await loadMember();
    post.uid = member.uid;
    post.fullname = member.fullname;
    post.img_user = member.img_url;
    post.date = UtilsService.currentDate();

    String postId = _firestore
        .collection(folder_users)
        .doc(member.uid)
        .collection(folder_posts)
        .doc()
        .id;

    post.id = postId;

    await _firestore
        .collection(folder_users)
        .doc(member.uid)
        .collection(folder_posts)
        .doc(postId)
        .set(post.toJson());

    LogService.i("postId: ${postId}");

    return post;
  }
}
