import 'package:flutter/material.dart';
import '../../../../core/wrappers/figtree_text.dart';

class CustomBoxWidgets extends StatelessWidget {
  final String userName;
  final String userImage;
  final String description;
  final String date;
  final String time;
  final String postImage;
  final bool isLiked;
  final VoidCallback onLikeToggle;
  final VoidCallback? onShift;
  final VoidCallback? onComment;

  const CustomBoxWidgets({
    super.key,
    required this.userName,
    required this.userImage,
    required this.description,
    required this.date,
    required this.time,
    required this.postImage,
    required this.isLiked,
    required this.onLikeToggle,
    this.onShift,
    this.onComment,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onShift,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xff0C131E),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(userImage),
                  backgroundColor: Colors.grey[300],
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FigtreeText(
                        text: userName,
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(height: 2),
                      FigtreeText(
                        text: '$date • $time',
                        color: Color(0xffE5E7EB),
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            FigtreeText(
              text: description,
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(height: 16),
            Image.asset(postImage, width: 350, height: 200, fit: BoxFit.cover),
            SizedBox(height: 16),
            Row(
              children: [
                GestureDetector(
                  onTap: onLikeToggle,
                  child: _buildActionButton(
                    icon: Icons.favorite,
                    label: 'Like',
                    color: isLiked ? Color(0xffF20333) : Colors.grey[400]!,
                  ),
                ),
                SizedBox(width: 24),
                GestureDetector(
                  onTap: onComment,
                  child: _buildActionButton(
                    icon: Icons.chat_bubble_outline,
                    label: 'Comment',
                    color: Colors.grey[400]!,
                  ),
                ),
                Spacer(),
                _buildActionButton(
                  icon: Icons.share,
                  label: 'Share',
                  color: Colors.grey[400]!,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 6),
        FigtreeText(
          text: label,
          color: Color(0xffF9FAFB),
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }
}
