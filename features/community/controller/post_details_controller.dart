import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/resources/assets_paths/images_assets_paths.dart';

class PostDetailsController extends GetxController {
  var posts = <Map<String, dynamic>>[].obs;
  var comments = <Map<String, dynamic>>[].obs;
  var isCommentFieldVisible = false.obs;
  var replyingToCommentId = ''.obs;
  final commentController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
    fetchComments();
  }

  void fetchPosts() {
    posts.addAll([
      {
        'userName': 'John Doe',
        'userImage':
            'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
        'description':
            'Qorem ipsum dolor sit amet, consectetur adipiscing elit.',
        'date': 'April 06, 2025',
        'time': '6:20 pm',
        'postImage': ImagePath.instance.graph,
        'isLiked': true,
      },
    ]);
  }

  void fetchComments() {
    comments.addAll([
      {
        'id': '1',
        'userName': 'Abdul Rahman',
        'userImage':
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
        'comment':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis.',
        'time': '1h',
        'replies': [
          {
            'id': '1-1',
            'userName': 'John Doe',
            'userImage':
                'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
            'comment': 'Thanks for your comment!',
            'time': '45m',
          },
        ],
      },
      {
        'id': '2',
        'userName': 'Abdul Rahman',
        'userImage':
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
        'comment':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis.',
        'time': '1h',
        'replies': [],
      },
      {
        'id': '3',
        'userName': 'Abdul Rahman',
        'userImage':
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
        'comment':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis.',
        'time': '1h',
        'replies': [],
      },
    ]);
  }

  void toggleLike(int index) {
    posts[index]['isLiked'] = !(posts[index]['isLiked'] ?? false);
    posts.refresh();
  }

  void showCommentField() {
    isCommentFieldVisible.value = true;
    replyingToCommentId.value = '';
  }

  void showReplyField(String commentId) {
    isCommentFieldVisible.value = true;
    replyingToCommentId.value = commentId;
  }

  void hideCommentField() {
    isCommentFieldVisible.value = false;
    replyingToCommentId.value = '';
  }

  void addComment(String commentText) {
    if (commentText.trim().isEmpty) return;

    if (replyingToCommentId.value.isEmpty) {
      // Adding a new comment
      comments.add({
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'userName': 'Current User',
        'userImage':
            'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
        'comment': commentText,
        'time': 'now',
        'replies': [],
      });
    } else {
      // Adding a reply
      int commentIndex = comments.indexWhere(
        (comment) => comment['id'] == replyingToCommentId.value,
      );
      if (commentIndex != -1) {
        List<dynamic> replies = comments[commentIndex]['replies'] ?? [];
        replies.add({
          'id': DateTime.now().millisecondsSinceEpoch.toString(),
          'userName': 'Current User',
          'userImage':
              'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
          'comment': commentText,
          'time': 'now',
        });
        comments[commentIndex]['replies'] = replies;
        comments.refresh();
      }
    }

    hideCommentField();
  }
}
