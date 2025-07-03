
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:health_house/core/resources/assets_paths/icon_assets_paths.dart';
import 'package:health_house/core/wrappers/figtree_text.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: FigtreeText(
          text: 'Notifications',
          fontWeight: FontWeight.w600,
          fontSize: 20,
          color: Colors.white,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      // appBar: AppBar(
      //   backgroundColor: Colors.black,
      //   title: Text('All', style: TextStyle(color: Colors.white)),
      //   actions: [
      //     TextButton(
      //       onPressed: () {},
      //       child: Text('Mark all as read', style: TextStyle(color: Colors.blue)),
      //     ),
      //   ],
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FigtreeText(
                    text: 'All',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  FigtreeText(
                    text: 'Mark all as read',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ],
              ),
              Gap(16),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 15),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image.asset(IconPath.instance.alarmClock, height: 24, width: 24,),
                              Gap(24),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FigtreeText(
                                    text: 'HealthHosue v2.1 Released!',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                  Gap(8),
                                  FigtreeText(
                                    text: 'HealthHosue v2.1 Released!',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              Spacer(),
                              Icon(Icons.circle, color: Colors.red, size: 12),
                            ],
                          ),
                          Gap(15),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: FigtreeText(
                              text: '09:00 AM  15/04/2025',
                              fontWeight: FontWeight.w400,
                              fontSize: 11,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    );
                    // return ListTile(
                    //   leading: CircleAvatar(
                    //     backgroundColor: Colors.orange,
                    //     child: Icon(Icons.notifications, color: Colors.white),
                    //   ),
                    //   title: Text('HealthHouse v2.1 Released!',
                    //       style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    //   subtitle: Text('HealthHouse v1 Released!',
                    //       style: TextStyle(color: Colors.grey)),
                    //   trailing: Icon(Icons.circle, color: Colors.red, size: 12),
                    //   contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    // );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}