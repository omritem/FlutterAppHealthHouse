
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:health_house/core/wrappers/figtree_text.dart';


class LegalAndPoliciesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FigtreeText(text: 'Legal and Policies', fontWeight: FontWeight.w600, fontSize: 20),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
          
                FigtreeText(text: 'Terms', fontWeight: FontWeight.w600, fontSize: 16),
                Gap(5),
                FigtreeText(text: '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor. Sapien, consequat ultrices morbi orci semper sit nulla. Leo auctor ut etiam est, amet aliquet ut vivamus. Odio vulputate est id tincidunt fames. \n\n Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor. Sapien, consequat ultrices morbi orci semper sit nulla. Leo auctor ut etiam est, amet aliquet ut vivamus. Odio vulputate est id tincidunt fames.''', fontWeight: FontWeight.w400, fontSize: 14),
                Gap(30),
                FigtreeText(text: 'Changes to the Service and/or Terms:', fontWeight: FontWeight.w600, fontSize: 16),
                Gap(5),
                FigtreeText(text: '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor. Sapien, consequat ultrices morbi orci semper sit nulla. Leo auctor ut etiam est, amet aliquet ut vivamus. Odio vulputate est id tincidunt fames.\n\n Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor. Sapien, consequat ultrices morbi orci semper sit nulla. Leo auctor ut etiam est, amet aliquet ut vivamus. Odio vulputate est id tincidunt fames.''', fontWeight: FontWeight.w400, fontSize: 14),
          
          
              ],
            ),
          ),
        ),
      ),
    );
  }


}