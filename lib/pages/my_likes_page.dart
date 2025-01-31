import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instaclone/controllers/my_likes_controller.dart';

import '../models/post_model.dart';

class MyLikesPage extends StatefulWidget {
  const MyLikesPage({super.key});

  @override
  State<MyLikesPage> createState() => _MyLikesPageState();
}

class _MyLikesPageState extends State<MyLikesPage> {
  var likesController = Get.find<MyLikesController>();

  @override
  void initState() {
    super.initState();
    likesController.apiLoadLikes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text("Likes"),
        ),
        body: GetBuilder<MyLikesController>(
          builder: (_) {
            return Stack(
              children: [
                ListView.builder(
                  itemCount: likesController.items.length,
                  itemBuilder: (ctx, index) {
                    return _itemOfPost(likesController.items[index]);
                  },
                ),
                likesController.isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : SizedBox.shrink(),
              ],
            );
          },
        ));
  }

  Widget _itemOfPost(Post post) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Divider(),
          // #user_info

          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: post.img_user.isEmpty
                          ? Image(
                              image: AssetImage("assets/images/ic_person.png"),
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              post.img_user,
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.fullname,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          post.date,
                          style: TextStyle(fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ],
                ),
                post.mine
                    ? IconButton(
                        onPressed: () {
                          likesController.dialogRemovePost(context,post);
                        },
                        icon: Icon(Icons.more_horiz),
                      )
                    : SizedBox.shrink(),
              ],
            ),
          ),

          //#post image
          SizedBox(
            height: 8,
          ),
          CachedNetworkImage(
            width: MediaQuery.of(context).size.width,
            imageUrl: post.img_post,
            fit: BoxFit.cover,
          ),

          //# like_share
          Row(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        if (post.liked) {
                          likesController.apiUnlikePost(post);
                        }
                      },
                      icon: Icon(
                        EvaIcons.heart,
                        color: Colors.red,
                      )),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      EvaIcons.shareOutline,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),

          //#caption
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: Text(
              post.caption,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
