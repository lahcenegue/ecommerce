import 'package:ecommerce/core/utils/app_colors.dart';
import 'package:ecommerce/core/utils/cache_helper.dart';
import 'package:ecommerce/screens/add_ads.dart';
import 'package:ecommerce/screens/categories2.dart';
import 'package:ecommerce/screens/login_mobile_screen.dart';
import 'package:ecommerce/screens/my_account.dart';
import 'package:ecommerce/screens/my_announces.dart';
import 'package:ecommerce/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/utils/app_icons.dart';
import '../core/widgets/costum_bottom_bar.dart';
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
  int selectedIndex = 0;

  int page = 1;
  List pages = [];

  @override
  Widget build(BuildContext context) {
    if (CacheHelper.getData(key: PrefKeys.token) == null) {
      pages = const [
        MainScreen(),
        Categories2(),
        // CategoriesScreen(),
        LoginMobileScreen(),
        MoreScreen(),
      ];
      if ((Provider.of<HomeViewModel>(context).listCategories == null) ||
          (Provider.of<HomeViewModel>(context).mainData == null)) {
        return const SplashScreen();
      }
    } else {
      pages = const [
        MainScreen(),
        Categories2(),
        //CategoriesScreen(),
        MyAnnonces(),
        MyAccount(),
      ];

      if ((Provider.of<HomeViewModel>(context).listCategories == null) ||
          (Provider.of<HomeViewModel>(context).mainData == null) ||
          (Provider.of<HomeViewModel>(context).profilInfo == null) ||
          (Provider.of<HomeViewModel>(context).myAds == null)) {
        return const SplashScreen();
      }
    }

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (CacheHelper.getData(key: PrefKeys.token) == null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginMobileScreen(),
                ),
              );
            } else {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddAdsScreen(
                    catNames: Provider.of<HomeViewModel>(context).catNames,
                    listCategories:
                        Provider.of<HomeViewModel>(context).listCategories!,
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
