import 'package:ecommerce/screens/favorite_screen.dart';
import 'package:ecommerce/screens/help_screen.dart';
import 'package:ecommerce/screens/login_mobile_screen.dart';
import 'package:flutter/material.dart';
import '../core/utils/app_colors.dart';
import '../core/widgets/costtum_card.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

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
                  //log in
                  custtomCard(
                    icon: Icon(
                      Icons.login,
                      color: AppColors.primary,
                    ),
                    title: 'تسجيل الدخول',
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const LoginMobileScreen()),
                        (Route<dynamic> route) => false,
                      );
                    },
                  ),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
