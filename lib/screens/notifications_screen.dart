import 'package:ecommerce/core/utils/app_colors.dart';
import 'package:ecommerce/core/utils/cache_helper.dart';
import 'package:flutter/material.dart';

import '../ViewModels/notification_view_model.dart';
import '../homeViewModel/home_view_model.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  HomeViewModel hvm = HomeViewModel();
  final controller = ScrollController();

  List<NotificationViewModel> notifications = [];
  bool isLoadingMore = false;
  int page = 1;
  bool getdata = false;

  @override
  void initState() {
    controller.addListener(_scrollListener);
    hvm.fetchListNotification(
      token: CacheHelper.getData(key: PrefKeys.token),
      page: page,
    );

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;

    hvm.addListener(() {
      setState(() {});
    });
    if (hvm.listNotification == null) {
      setState(() {
        getdata = false;
      });
    } else {
      setState(() {
        getdata = true;
        notifications = notifications + hvm.listNotification!;
      });
    }

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
              child: getdata == false
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.all(20),
                      itemCount: notifications.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 08),
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    notifications[index].title,
                                    style: TextStyle(
                                      fontSize: heightScreen * 0.022,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 08),
                                  Text(
                                    notifications[index].comment,
                                    style: TextStyle(
                                      fontSize: heightScreen * 0.018,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Text(
                                notifications[index].time,
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

  Future<void> _scrollListener() async {
    if (isLoadingMore) return;
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      setState(() {
        isLoadingMore = true;
      });
      await Future.delayed(const Duration(seconds: 2));
      page = page + 1;
      await hvm
          .fetchListNotification(
              token: CacheHelper.getData(key: PrefKeys.token), page: page)
          .then(
        (value) {
          setState(
            () {
              isLoadingMore = false;
            },
          );
        },
      );
    }
  }
}
