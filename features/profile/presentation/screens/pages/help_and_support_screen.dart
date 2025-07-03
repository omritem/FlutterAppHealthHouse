
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_house/core/wrappers/figtree_text.dart';

class FaqItem {
  final String question;
  final String answer;

  FaqItem({required this.question, required this.answer});

  factory FaqItem.fromString(String combined) {
    final parts = combined.split('\n');
    return FaqItem(
      question: parts.first,
      answer: parts.length > 1 ? parts.sublist(1).join('\n') : 'No answer provided',
    );
  }
}

class DraggableListController extends GetxController {
  final items = <FaqItem>[
    FaqItem(
      question: "Lorem ipsum dolor sit amet",
      answer: "Dummy details for item 1: This is a sample description.",
    ),
    FaqItem(
      question: "Lorem ipsum dolor sit amet",
      answer: "Dummy details for item 2: Additional info here.",
    ),
    FaqItem(
      question: "Lorem ipsum dolor sit amet",
      answer: "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Excepteur veniam consequat sunt nostrud amet.\nDummy details for item 3: More sample text.",
    ),
    FaqItem(
      question: "Lorem ipsum dolor sit amet",
      answer: "Dummy details for item 4: Another example.",
    ),
    FaqItem(
      question: "Lorem ipsum dolor sit amet",
      answer: "Dummy details for item 5: Extra info provided.",
    ),
  ].obs;

  void reorderItems(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex -= 1;
    final item = items.removeAt(oldIndex);
    items.insert(newIndex, item);
  }
}

class HelpAndSupportScreen extends StatelessWidget {
  final DraggableListController controller = Get.put(DraggableListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FigtreeText(text: 'Help and Support', fontWeight: FontWeight.w600, fontSize: 20),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Expanded(
              child: Obx(() => ReorderableListView.builder(
                padding: const EdgeInsets.only(bottom: 16),
                itemCount: controller.items.length,
                itemBuilder: (context, index) {
                  final item = controller.items[index];
                  return _buildFaqCard(item, index, context);
                },
                onReorder: controller.reorderItems,
              )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqCard(FaqItem item, int index, BuildContext context) {
    return Card(
      key: ValueKey(index),
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      color: Colors.transparent,
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent, // This removes the divider
          unselectedWidgetColor: Colors.white,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: ExpansionTile(
            tilePadding: EdgeInsets.zero, // Add this to remove default padding
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: FigtreeText(text: item.question, fontWeight: FontWeight.w500, fontSize: 16),
            ),
            trailing: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ReorderableDragStartListener(
                index: index,
                child: const Icon(Icons.arrow_drop_down, color: Colors.white),
              ),
            ),
            iconColor: Colors.white,
            collapsedIconColor: Colors.white,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),

                child: FigtreeText(text: item.answer, fontWeight: FontWeight.w400, fontSize: 14),
              ),
              Divider(color: Colors.white,),
            ],
          ),
        ),
      ),
    );
  }

}