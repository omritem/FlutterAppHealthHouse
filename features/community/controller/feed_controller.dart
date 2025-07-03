import 'package:get/get.dart';
import 'package:health_house/core/resources/assets_paths/images_assets_paths.dart';

class FeedController extends GetxController {

  var posts = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
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
      {
        'userName': 'Jane Smith',
        'userImage':
            'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
        'description':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt.',
        'date': 'April 05, 2025',
        'time': '4:15 pm',
        'postImage': ImagePath.instance.graph,
        'isLiked': false,
      },
      {
        'userName': 'Mike Johnson',
        'userImage':
            'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
        'description':
            'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.',
        'date': 'April 04, 2025',
        'time': '2:30 pm',
        'postImage': ImagePath.instance.graph,
        'isLiked': false,
      },
    ]);
  }

  void toggleLike(int index) {
    posts[index]['isLiked'] = !(posts[index]['isLiked'] ?? false);
    posts.refresh(); // Notify UI to rebuild with updated like state
  }

}
