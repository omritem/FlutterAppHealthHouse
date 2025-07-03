import 'package:flutter/material.dart';
import 'package:health_house/core/utils/constants/icon_path.dart';
import 'package:health_house/core/wrappers/figtree_text.dart';

class RankWidget extends StatelessWidget {
  const RankWidget({
    super.key,
    required this.image,
    required this.name,
    required this.date,
    required this.coin,
    required this.step,
    required this.rank,
  });

  final String image;
  final String name;
  final String date;
  final String coin;
  final String step;
  final String rank;

  @override
  Widget build(BuildContext context) {
    Widget rankIcon;
    if (rank == '1') {
      rankIcon = Image.asset(
        IconPath1.first,
        width: 24,
        height: 31,
        fit: BoxFit.cover,
      );
    } else if (rank == '2') {
      rankIcon = Image.asset(
        IconPath1.second,
        width: 24,
        height: 31,
        fit: BoxFit.cover,
      );
    } else if (rank == '3') {
      rankIcon = Image.asset(
        IconPath1.third,
        width: 24,
        height: 31,
        fit: BoxFit.cover,
      );
    } else {
      rankIcon = FigtreeText(
        text: rank,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      );
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 40,
                width: 40,
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4.5),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xffFAAD14)),
                ),
                child: Center(child: rankIcon),
              ),
              SizedBox(width: 12),
              ClipOval(
                child: Image.network(
                  image,
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FigtreeText(
                    text: name,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  FigtreeText(
                    text: "Last: $date",
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ],
          ),

          Row(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        IconPath1.coin,
                        width: 16,
                        height: 16,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(width: 4),
                      FigtreeText(
                        text: coin,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset(
                        IconPath1.shoo,
                        width: 16,
                        height: 16,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(width: 4),
                      FigtreeText(
                        text: step,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
