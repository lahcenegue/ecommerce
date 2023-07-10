import 'package:ecommerce/screens/favorite_screen.dart';
import 'package:ecommerce/screens/help_screen.dart';
import 'package:flutter/material.dart';

import '../core/utils/app_colors.dart';
import '../core/widgets/costtum_card.dart';
import 'edit_profil_screen.dart';

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
            child: Column(
              children: [
                Container(
                  width: widthScreen,
                  height: heightScreen * 0.3,
                  padding: const EdgeInsets.only(right: 18),
                  color: AppColors.primary,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const EditProfilScreen(),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        SizedBox(height: heightScreen * 0.08),
                        Row(
                          children: [
                            Container(
                              height: heightScreen * 0.08,
                              width: heightScreen * 0.08,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Column(
                              children: [
                                Text(
                                  'مرام السالمي',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 08),
                                Text(
                                  '+96512345678',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // child: Row(
                  //   children: [
                  //     Container(
                  //       width: widthScreen * 0.15,
                  //       decoration: const BoxDecoration(
                  //         shape: BoxShape.circle,
                  //         color: Colors.green,
                  //       ),
                  //     ),
                  //     Text('data')
                  //   ],
                  // ),
                ),
                SizedBox(
                  height: heightScreen * 0.6,
                  width: widthScreen,
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
                      icon: Icon(
                        Icons.notifications,
                        color: AppColors.primary,
                      ),
                      title: 'تفعيل الاشعارات',
                      onTap: () {
                        print('notification');
                      },
                    ),
                    // favorite
                    custtomCard(
                      icon: Icon(
                        Icons.favorite,
                        color: AppColors.primary,
                      ),
                      title: 'المفضلة',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const FavoriteScreen(),
                          ),
                        );
                      },
                    ),
                    //help
                    custtomCard(
                      icon: Icon(
                        Icons.help,
                        color: AppColors.primary,
                      ),
                      title: 'المساعدة',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const HelpScreen(),
                          ),
                        );
                      },
                    ),
                    //log out
                    custtomCard(
                      icon: Icon(
                        Icons.logout_rounded,
                        color: AppColors.primary,
                      ),
                      title: 'تسجيل الخروج',
                      onTap: () {
                        print('logout');
                      },
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
