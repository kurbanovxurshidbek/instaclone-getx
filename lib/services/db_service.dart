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
  static String folder_feeds = "feeds";

  /// Member Related
  static Future storeMember(Member member) async {
    member.uid = AuthService.currentUserId();

    return _firestore
        .collection(folder_users)
        .doc(member.uid)
        .set(member.toJson());
  }

  static Future updateMember(Member member) async {
    String uid = AuthService.currentUserId();

    return _firestore.collection(folder_users).doc(uid).update(member.toJson());
  }

  static Future loadMember() async {
    String uid = AuthService.currentUserId();
    var value = await _firestore.collection(folder_users).doc(uid).get();
    Member member = Member.fromJson(value.data()!);

    return member;
  }

  static Future<List<Member>> searchMembers(String keyword) async {
    List<Member> members = [];
    String uid = AuthService.currentUserId();

    var querySnapshot = await _firestore
        .collection(folder_users)
        .orderBy("email")
        .startAt([keyword]).get();
    LogService.i(querySnapshot.docs.length.toString());

    for (var result in querySnapshot.docs) {
      Member newMember = Member.fromJson(result.data());
      if (uid != newMember.uid) {
        members.add(newMember);
      }
    }
    return members;
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

  static Future<Post> storeFeed(Post post) async {
    String uid = AuthService.currentUserId();

    await _firestore
        .collection(folder_users)
        .doc(uid)
        .collection(folder_feeds)
        .doc(post.id)
        .set(post.toJson());
    return post;
  }

  static Future<List<Post>> loadFeeds() async {
    List<Post> posts = [];
    String uid = AuthService.currentUserId();
    var querySnapshot = await _firestore
        .collection(folder_users)
        .doc(uid)
        .collection(folder_feeds)
        .get();

    for (var result in querySnapshot.docs) {
      Post post = Post.fromJson(result.data());
      if (post.uid == uid) {
        post.mine = true;
      }
      posts.add(post);
    }
    return posts;
  }

  static Future<List<Post>> loadPosts() async {
    List<Post> posts = [];
    String uid = AuthService.currentUserId();
    var querySnapshot = await _firestore
        .collection(folder_users)
        .doc(uid)
        .collection(folder_posts)
        .get();

    for (var result in querySnapshot.docs) {
      Post post = Post.fromJson(result.data());
      if (post.uid == uid) {
        post.mine = true;
      }
      posts.add(post);
    }
    return posts;
  }

  static Future<List<Post>> loadLikes() async {
    List<Post> posts = [];
    String uid = AuthService.currentUserId();
    var querySnapshot = await _firestore
        .collection(folder_users)
        .doc(uid)
        .collection(folder_feeds)
        .where("liked", isEqualTo: true)
        .get();

    for (var result in querySnapshot.docs) {
      Post post = Post.fromJson(result.data());
      if (post.uid == uid) {
        post.mine = true;
      }
      posts.add(post);
    }
    return posts;
  }

  static Future likePost(Post post, bool liked) async {
    String uid = AuthService.currentUserId();
    post.liked = liked;

    await _firestore
        .collection(folder_users)
        .doc(uid)
        .collection(folder_feeds)
        .doc(post.id)
        .set(post.toJson());

    if (uid == post.uid) {
      await _firestore
          .collection(folder_users)
          .doc(uid)
          .collection(folder_posts)
          .doc(post.id)
          .set(post.toJson());
    }
  }
}
