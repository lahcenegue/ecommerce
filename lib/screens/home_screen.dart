import 'package:ecommerce/core/utils/app_colors.dart';
import 'package:ecommerce/core/utils/cache_helper.dart';
import 'package:ecommerce/screens/add_ads.dart';
import 'package:ecommerce/screens/login_mobile_screen.dart';
import 'package:ecommerce/screens/my_account.dart';
import 'package:ecommerce/screens/my_announces.dart';
import 'package:ecommerce/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import '../core/utils/app_icons.dart';
import '../core/widgets/costum_bottom_bar.dart';
import '../core/widgets/signin_widget.dart';
import '../homeViewModel/home_view_model.dart';
import 'categories.dart';
import 'main_screen.dart';
import 'more_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewModel hvm = HomeViewModel();

  int page = 1;
  List pages = [];
  late String token;

  @override
  void initState() {
    if (CacheHelper.getData(key: PrefKeys.token) != null) {
      token = CacheHelper.getData(key: PrefKeys.token);
      hvm.fetchmyAds(
        token: token,
        page: page,
      );
      hvm.fetchProfilInfo(token: token);
    }
    hvm.fetchMainData();
    hvm.fetchCategories();

    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;

    hvm.addListener(() {
      setState(() {});
    });
    if ((hvm.mainData == null) || (hvm.listCategories == null)) {
      return const SplashScreen();
    } else {
      if (CacheHelper.getData(key: PrefKeys.token) == null) {
        pages = [
          MainScreen(
            urlImages: hvm.listBannerImages!,
            listCategories: hvm.listCategories!,
            mainData: hvm.mainData!,
          ),
          CategoriesScreen(
            categories: hvm.listCategories!,
          ),
          signinWidget(),
          const MoreScreen()
        ];
      } else {
        pages = [
          MainScreen(
            urlImages: hvm.listBannerImages!,
            listCategories: hvm.listCategories!,
            mainData: hvm.mainData!,
          ),
          CategoriesScreen(
            categories: hvm.listCategories!,
          ),
          MyAnnonces(
            mainData: hvm.mainData!,
          ),
          MyAccount(
            info: hvm.profilInfo!.info,
            mobile: hvm.profilInfo!.phone,
          ),
        ];
      }

      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (CacheHelper.getData(key: PrefKeys.token) == null) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text(
                        'Sooq.in',
                        textAlign: TextAlign.center,
                      ),
                      content: Text(
                        'الرجاء تسجيل الدخول أولاً للوصول إلى جميع الميزات الموجودة في Sooq.in',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: heightScreen * 0.02),
                      ),
                      actions: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(08),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginMobileScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'نسجيل الدخول',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('رجوع'),
                        ),
                      ],
                    );
                  },
                );
              } else {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddAdsScreen(
                      catNames: hvm.catNames,
                      listCategories: hvm.listCategories!,
                    ),
                  ),
                );
              }
            },
            child: Container(
              padding: const EdgeInsets.all(03),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary,
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 20,
              ),
            )),
        bottomNavigationBar: CustomBottomBar(
          selectedIndex: selectedIndex,
          items: [
            CostomNavigationItem(
              icon: AppIcons.home,
              lebel: 'الرئيسية',
              onTap: () {
                setState(() {
                  selectedIndex = 0;
                });
              },
            ),
            CostomNavigationItem(
              icon: AppIcons.category,
              lebel: 'الاقسام',
              onTap: () {
                setState(() {
                  selectedIndex = 1;
                });
              },
            ),
            CostomNavigationItem(
              icon: AppIcons.announce,
              lebel: 'إعلاناتي',
              onTap: () {
                setState(() {
                  selectedIndex = 2;
                });
              },
            ),
            CostomNavigationItem(
              icon: AppIcons.person,
              lebel: 'المزيد',
              onTap: () {
                setState(() {
                  selectedIndex = 3;
                });
              },
            ),
          ],
        ),
        body: pages[selectedIndex],
      );
    }
  }
}
