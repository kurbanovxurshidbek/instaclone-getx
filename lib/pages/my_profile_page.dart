import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instaclone/controllers/my_profile_controller.dart';

import '../models/post_model.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  var profileController = Get.find<MyProfileController>();

  @override
  void initState() {
    super.initState();
    profileController.addFewPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Profile"),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.exit_to_app,
              ),
              color: Color.fromRGBO(193, 53, 132, 1),
            ),
          ],
        ),
        body: GetBuilder<MyProfileController>(
          builder: (_) {
            return Column(
              children: [
                //#myphoto
                GestureDetector(
                  onTap: () {},
                  child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(70),
                          border: Border.all(
                              width: 1.5,
                              color: Color.fromRGBO(193, 53, 132, 1)),
                        ),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(35),
                            child: profileController.member_image == null ||
                                    profileController.member_image!.isEmpty
                                ? Image(
                                    image: AssetImage(
                                        "assets/images/ic_person.png"),
                                    width: 70,
                                    height: 70,
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    profileController.member_image!,
                                    width: 70,
                                    height: 70,
                                    fit: BoxFit.cover,
                                  )),
                      ),
                      Container(
                        width: 80,
                        height: 80,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.add_circle,
                              color: Colors.purple,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                //#myinfo
                Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      profileController.member_fullname!,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      profileController.member_email!,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),

                //#mycounts
                Container(
                  margin: EdgeInsets.only(top: 10),
                  height: 80,
                  child: Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Column(
                            children: [
                              Text(
                                profileController.count_posts.toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                "POST",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Column(
                            children: [
                              Text(
                                profileController.count_posts.toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                "FOLLOWERS",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Column(
                            children: [
                              Text(
                                profileController.count_posts.toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                "FOLLOWING",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //#list_or_grid

                Container(
                  child: Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              profileController.changeAxisCount(1);
                            },
                            icon: Icon(Icons.list_alt),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              profileController.changeAxisCount(2);
                            },
                            icon: Icon(Icons.grid_view),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //#myposts

                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: profileController.axisCount),
                    itemCount: profileController.items.length,
                    itemBuilder: (context, index) {
                      return _itemOfPost(profileController.items[index]);
                    },
                  ),
                ),
              ],
            );
          },
        ));
  }

  Widget _itemOfPost(Post post) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Column(
        children: [
          Expanded(
            child: CachedNetworkImage(
              width: double.infinity,
              imageUrl: post.img_post,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            post.caption,
            style: TextStyle(color: Colors.black87.withOpacity(0.7)),
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}
