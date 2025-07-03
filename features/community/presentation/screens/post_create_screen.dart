import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_house/core/widgets/custom_text_field.dart';
import 'package:health_house/features/community/controller/post_create_controller.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/wrappers/figtree_text.dart';

class PostCreateScreen extends StatelessWidget {
  PostCreateScreen({super.key});
  final postCreateController = Get.put(PostCreateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: FigtreeText(
          text: 'Create Post',
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: SizedBox(
              width: 80, // Fixed width to constrain the button
              child: CustomButton(
                title: "Post",
                onTap: () {
                  postCreateController.createPost();
                },
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Profile Section
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                      postCreateController.userProfileImage.value,
                    ),
                  ),
                  SizedBox(width: 12),
                  FigtreeText(
                    text: postCreateController.userName.value,
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Image Preview Section
              Obx(
                () => postCreateController.selectedImages.isNotEmpty
                    ? Wrap(
                        spacing: 10, // Horizontal spacing between images
                        runSpacing: 10, // Vertical spacing between rows
                        children: List.generate(
                          postCreateController.selectedImages.length,
                          (index) => Stack(
                            alignment: Alignment.topRight,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  postCreateController.selectedImages[index],
                                  height: 100, // Reduced image size
                                  width: 100, // Reduced image size
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                right: 4,
                                top: 4,
                                child: GestureDetector(
                                  onTap: () {
                                    postCreateController.removeImage(index);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
              ),
              SizedBox(height: 20),
              // Text Input Area
              CustomTextField(
                controller: postCreateController.postTextController,
                hintText: "What's on your mind? Let's talk.",
                radius: 0,
                containerColor: Colors.transparent,
                borderColor: Colors.transparent,
                maxLines: 20,
                textColor: Colors.white,
              ),
              SizedBox(height: 20),
              // Bottom Action Icons
              Row(
                children: [
                  // Camera Icon
                  GestureDetector(
                    onTap: () async {
                      await postCreateController.openCamera();
                    },
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Color(0xFF0C131E),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Color(0xff6A7381)),
                      ),
                      child: const Icon(
                        Icons.camera_alt_outlined,
                        color: Color(0xffF20333),
                        size: 24,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  // Gallery Icon
                  GestureDetector(
                    onTap: () async {
                      await postCreateController.openGallery();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Color(0xFF0C131E),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Color(0xff6A7381)),
                      ),
                      child: const Icon(
                        Icons.photo_outlined,
                        color: Color(0xffF20333),
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
