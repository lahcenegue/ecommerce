import 'package:ecommerce/screens/favorite_screen.dart';
import 'package:ecommerce/screens/help_screen.dart';
import 'package:ecommerce/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../core/utils/app_colors.dart';
import '../core/utils/cache_helper.dart';
import '../core/widgets/costtum_card.dart';
import '../data/logout_api.dart';
import 'edit_profil_screen.dart';

class MyAccount extends StatefulWidget {
  final String info;
  final String mobile;
  const MyAccount({
    super.key,
    required this.info,
    required this.mobile,
  });

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  bool isApiCallProcess = false;
  bool isPermi = true;

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
                            Column(
                              children: [
                                Text(
                                  widget.info,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: heightScreen * 0.03,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: heightScreen * 0.01),
                                Text(
                                  widget.mobile,
                                  style: const TextStyle(
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
                  Container(
                    height: heightScreen * 0.08,
                    margin: const EdgeInsets.symmetric(vertical: 08),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(08),
                      color: Colors.white,
                    ),
                    child: SwitchListTile(
                      title: const Text('تفعيل الاشعارات'),
                      secondary: Icon(
                        Icons.notifications_active,
                        color: AppColors.primary,
                      ),
                      value: isPermi,
                      onChanged: (value) async {
                        if (await Permission.notification.isGranted) {
                          setState(() {
                            isPermi = true;
                          });
                        } else {
                          setState(() {
                            isPermi = false;
                          });
                        }
                        await openAppSettings();
                      },
                    ),
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
                    onTap: () async {
                      setState(() {
                        isApiCallProcess = true;
                      });
                      await logoutApi(
                              token: CacheHelper.getData(key: PrefKeys.token))
                          .then((value) async {
                        setState(() {
                          isApiCallProcess = false;
                        });
                        if (value.logout == 'ok') {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()),
                            (Route<dynamic> route) => false,
                          );
                          CacheHelper.removeData(key: PrefKeys.name);
                          CacheHelper.removeData(key: PrefKeys.token);
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: isApiCallProcess ? true : false,
            child: Stack(
              children: [
                ModalBarrier(
                  color: Colors.white.withOpacity(0.6),
                  dismissible: true,
                ),
                const Center(
                  child: CircularProgressIndicator(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
