import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instaclone/controllers/my_upload_controller.dart';

class MyUploadPage extends StatefulWidget {
  final PageController pageController;

  const MyUploadPage({super.key, required this.pageController});

  @override
  State<MyUploadPage> createState() => _MyUploadPageState();
}

class _MyUploadPageState extends State<MyUploadPage> {
  var uploadController = Get.find<MyUploadController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Upload"),
        actions: [
          IconButton(
            onPressed: () {
              uploadController.uploadNewPost(widget.pageController);
            },
            icon: const Icon(
              Icons.drive_folder_upload,
              color: Color.fromRGBO(193, 53, 132, 1),
            ),
          )
        ],
      ),
      body: GetBuilder<MyUploadController>(
        builder: (_) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          uploadController.imgFromGallery();
                        },
                        child: Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.width,
                          color: Colors.grey.withOpacity(0.4),
                          child: uploadController.pickedImage == null
                              ? Center(
                                  child: Icon(
                                    Icons.add_a_photo,
                                    size: 50,
                                    color: Colors.grey,
                                  ),
                                )
                              : Stack(
                                  children: [
                                    Image.file(
                                      uploadController.pickedImage!,
                                      width: double.infinity,
                                      height: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      color: Colors.black12,
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              uploadController
                                                  .removePickedImage();
                                            },
                                            icon: Icon(
                                              Icons.highlight_remove,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: TextField(
                          controller: uploadController.captionController,
                          style: TextStyle(color: Colors.black),
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText: "Caption",
                            hintStyle:
                                TextStyle(fontSize: 17, color: Colors.black38),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              uploadController.isLoading
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
}
