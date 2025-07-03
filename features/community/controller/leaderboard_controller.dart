import 'package:get/get.dart';

class LeaderboardController extends GetxController {
  final RxList<Map<String, String>> _rankData = <Map<String, String>>[].obs;

  List<Map<String, String>> get rankData => _rankData;

  @override
  void onInit() {
    super.onInit();
    _rankData.assignAll([
      {
        'image':
            'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
        'name': 'Andre',
        'date': 'may 12, 2025',
        'coin': '110k',
        'step': '200k',
        'rank': '1',
      },
      {
        'image':
            'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
        'name': 'Brandon Gray',
        'date': 'may 12, 2025',
        'coin': '110k',
        'step': '200k',
        'rank': '2',
      },
      {
        'image':
            'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
        'name': 'Sukuma',
        'date': 'may 12, 2025',
        'coin': '110k',
        'step': '200k',
        'rank': '3',
      },
      {
        'image':
            'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
        'name': 'Andre',
        'date': 'may 12, 2025',
        'coin': '110k',
        'step': '200k',
        'rank': '4',
      },
      {
        'image':
            'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
        'name': 'Andre',
        'date': 'may 12, 2025',
        'coin': '110k',
        'step': '200k',
        'rank': '5',
      },
      {
        'image':
            'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60',
        'name': 'Andre',
        'date': 'may 12, 2025',
        'coin': '110k',
        'step': '200k',
        'rank': '6',
      },
    ]);
  }
}