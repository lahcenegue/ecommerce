import 'package:ecommerce/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: heightScreen * 0.3,
                width: widthScreen,
                color: AppColors.primary,
                padding: const EdgeInsets.only(
                  right: 20,
                  bottom: 50,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: heightScreen * 0.04),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: heightScreen * 0.04,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'الاشعارات',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: heightScreen * 0.04,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: heightScreen * 0.7,
                width: widthScreen,
              ),
            ],
          ),
          Positioned(
            top: heightScreen * 0.25,
            child: SizedBox(
              height: heightScreen * 0.75,
              width: widthScreen,
              child: ListView.separated(
                padding: const EdgeInsets.all(20),
                itemCount: 15,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 08),
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'عنوان الاشعار',
                          style: TextStyle(
                            fontSize: heightScreen * 0.022,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 08),
                        Text(
                          'محتوى الاشعار',
                          style: TextStyle(
                            fontSize: heightScreen * 0.018,
                          ),
                        ),
                      ],
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
