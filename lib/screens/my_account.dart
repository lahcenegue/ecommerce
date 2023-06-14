import 'package:flutter/material.dart';

import '../core/utils/app_colors.dart';
import '../core/widgets/costtum_card.dart';

class MyAccount extends StatelessWidget {
  const MyAccount({super.key});

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          SizedBox(
            height: heightScreen,
            width: widthScreen,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: widthScreen,
                  height: heightScreen * 0.3,
                  padding: const EdgeInsets.all(18),
                  color: AppColors.primary,
                  child: Row(
                    children: [
                      Container(
                        width: widthScreen * 0.15,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              top: heightScreen * 0.19,
              child: Container(
                height: heightScreen * 0.6,
                width: widthScreen,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 05,
                ),
                child: ListView(
                  children: [
                    // notification
                    custtomCard(
                      icon: const Icon(Icons.notifications),
                      title: 'notification',
                    ),
                    // favorite
                    custtomCard(
                      icon: const Icon(Icons.favorite_border),
                      title: 'notification',
                    ),
                    //help
                    custtomCard(
                      icon: const Icon(Icons.help),
                      title: 'notification',
                    ),
                    //log out
                    custtomCard(
                      icon: const Icon(Icons.logout),
                      title: 'notification',
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
