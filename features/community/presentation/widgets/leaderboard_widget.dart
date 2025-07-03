import 'package:flutter/material.dart';
import 'package:health_house/core/widgets/dynamic_container.dart';
import 'package:health_house/core/wrappers/figtree_text.dart';
import 'rank_widget.dart';

class LeaderboardWidget extends StatelessWidget {
  final String image;
  final String rank;
  final String title;
  final List<Map<String, String>> rankData;

  const LeaderboardWidget({
    super.key,
    required this.image,
    required this.rank,
    required this.title,
    this.rankData = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: ClipOval(
              child: Image.network(
                image,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 16),
          FigtreeText(text: rank, fontSize: 48, fontWeight: FontWeight.w600),
          FigtreeText(text: title, fontSize: 16, fontWeight: FontWeight.w400),
          SizedBox(height: 16),
          Align(
            alignment: Alignment.topLeft,
            child: FigtreeText(
              text: "All",
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16),
          SizedBox(
            height: 430,
            child: DynamicContainer(
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: rankData.length,
                itemBuilder: (context, index) {
                  final data = rankData[index];
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: 16,
                    ), // Add 16px bottom space
                    child: RankWidget(
                      image: data['image'] ?? image,
                      name: data['name'] ?? 'Unknown',
                      date: data['date'] ?? 'Unknown',
                      coin: data['coin'] ?? '0',
                      step: data['step'] ?? '0',
                      rank: data['rank'] ?? '0',
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
