import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_house/core/widgets/custom_text_field.dart';
import 'package:health_house/features/community/controller/post_details_controller.dart';
import '../../../../core/wrappers/figtree_text.dart';
import '../widgets/custom_box_widgets.dart';

class PostDetailsScreen extends StatelessWidget {
  PostDetailsScreen({super.key, this.post});
  final Map<String, dynamic>? post;
  final controller = Get.put(PostDetailsController());

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> singlePost =
        post ?? Get.arguments ?? controller.posts[0];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: FigtreeText(
          text: '${singlePost['userName'] ?? 'Unknown'}s Post',
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    CustomBoxWidgets(
                      onComment: () => controller.showCommentField(),
                      postImage: singlePost['postImage'] ?? '',
                      userName: singlePost['userName'] ?? 'Unknown',
                      userImage: singlePost['userImage'] ?? '',
                      description: singlePost['description'] ?? '',
                      date: singlePost['date'] ?? '',
                      time: singlePost['time'] ?? '',
                      isLiked: controller.posts.isNotEmpty
                          ? controller.posts[0]['isLiked'] ?? false
                          : false,
                      onLikeToggle: () => controller.toggleLike(0),
                    ),
                    const SizedBox(height: 16),

                    // Comments Section
                    Obx(
                      () => ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.comments.length,
                        itemBuilder: (context, index) {
                          final comment = controller.comments[index];
                          return _buildCommentItem(comment, context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Comment Input Field
          Obx(
            () => controller.isCommentFieldVisible.value
                ? _buildCommentInputField(context)
                : _buildAddCommentButton(context),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentItem(Map<String, dynamic> comment, BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Color(0xff0C131E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(comment['userImage'] ?? ''),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        FigtreeText(
                          text: comment['userName'] ?? '',
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        const SizedBox(width: 8),
                        FigtreeText(
                          text: comment['time'] ?? '',
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    FigtreeText(
                      text: comment['comment'] ?? '',
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () => controller.showReplyField(comment['id']),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const FigtreeText(
                          text: 'Reply',
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Replies
          if (comment['replies'] != null &&
              (comment['replies'] as List).isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 44, top: 12),
              child: Column(
                children: (comment['replies'] as List).map<Widget>((reply) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundImage: NetworkImage(
                            reply['userImage'] ?? '',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  FigtreeText(
                                    text: reply['userName'] ?? '',
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  const SizedBox(width: 8),
                                  FigtreeText(
                                    text: reply['time'] ?? '',
                                    color: Colors.grey,
                                    fontSize: 11,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              FigtreeText(
                                text: reply['comment'] ?? '',
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAddCommentButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color(0xFF0C131E),
        border: Border(top: BorderSide(color: Colors.grey, width: 0.2)),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage(
              'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: GestureDetector(
              onTap: () => controller.showCommentField(),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(20),
                ),
                child:  FigtreeText(
                  text: 'Add a comment',
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentInputField(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color(0xFF2A2A2A),
        border: Border(top: BorderSide(color: Colors.grey, width: 0.2)),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage(
              'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: CustomTextField(
              hintText: controller.replyingToCommentId.value.isEmpty
                  ? 'Add a comment'
                  : 'Add a reply',
              controller: controller.commentController,
            ),
          ),
          SizedBox(width: 8),
          IconButton(
            onPressed: () {
              controller.addComment(controller.commentController.text);
              controller.commentController.clear();
            },
            icon: const Icon(Icons.send, color: Colors.blue),
          ),
          IconButton(
            onPressed: () => controller.hideCommentField(),
            icon: Icon(Icons.close, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
