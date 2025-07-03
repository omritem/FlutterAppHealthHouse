import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingViewer extends StatelessWidget {
  const RatingViewer({
    super.key,
    required this.initialRating,
    required this.minRating,
    required this.itemCount,
    required this.onRatingUpdate,
    this.isIgnoreGesture,
  });

  final double initialRating;
  final double minRating;
  final int itemCount;
  final Function(double) onRatingUpdate;
  final bool? isIgnoreGesture;

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      ignoreGestures: isIgnoreGesture ?? false,
      initialRating: initialRating,
      minRating: minRating,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: itemCount,
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber, size: 30,),
      onRatingUpdate: onRatingUpdate,
    );
  }
}
