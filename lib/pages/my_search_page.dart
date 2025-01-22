import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instaclone/controllers/my_search_controller.dart';
import 'package:instaclone/models/member_model.dart';

class MySearchPage extends StatefulWidget {
  const MySearchPage({super.key});

  @override
  State<MySearchPage> createState() => _MySearchPageState();
}

class _MySearchPageState extends State<MySearchPage> {
  var searchController = Get.find<MySearchController>();

  @override
  void initState() {
    super.initState();
    searchController.addFakeMembers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Search"),
      ),
      body: GetBuilder<MySearchController>(
        builder: (_) {
          return Stack(
            children: [
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  children: [
                    //#search_member
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.only(left: 10, right: 10),
                      height: 45,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(7)),
                      child: TextField(
                        style: TextStyle(color: Colors.black87),
                        decoration: InputDecoration(
                            hintText: "Search",
                            border: InputBorder.none,
                            hintStyle:
                                TextStyle(fontSize: 15, color: Colors.grey),
                            icon: Icon(
                              Icons.search,
                              color: Colors.grey,
                            )),
                      ),
                    ),

                    //#member_list
                    Expanded(
                      child: ListView.builder(
                        itemCount: searchController.items.length,
                        itemBuilder: (context, index) {
                          return _itemOfMember(searchController.items[index]);
                        },
                      ),
                    )
                  ],
                ),
              ),
              searchController.isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : SizedBox.shrink(),
            ],
          );
        },
      ),
    );
  }

  Widget _itemOfMember(Member member) {
    return Container(
      height: 90,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(70),
              border: Border.all(
                  width: 1.5, color: Color.fromRGBO(193, 53, 132, 1)),
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(22.5),
                child: member.img_url.isEmpty
                    ? Image(
                        image: AssetImage("assets/images/ic_person.png"),
                        width: 45,
                        height: 45,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        member.img_url,
                        width: 45,
                        height: 45,
                        fit: BoxFit.cover,
                      )),
          ),
          SizedBox(
            width: 15,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                member.fullname,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                member.email,
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
            ],
          ),
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(width: 1, color: Colors.grey),
                    ),
                    child: Center(
                      child:
                          member.followed ? Text("Following") : Text("Follow"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
