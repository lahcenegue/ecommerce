import 'package:ecommerce/core/utils/app_colors.dart';
import 'package:ecommerce/screens/my_account.dart';
import 'package:ecommerce/screens/my_announces.dart';
import 'package:ecommerce/screens/splash_screen.dart';
import 'package:flutter/material.dart';

import '../core/utils/app_icons.dart';
import '../core/widgets/costum_bottom_bar.dart';
import '../homeViewModel/home_view_model.dart';
import 'gategories.dart';
import 'main_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeViewModel hvm;

  @override
  void initState() {
    hvm = HomeViewModel();
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
    hvm.addListener(() {
      setState(() {});
    });
    if (hvm.mainData == null || hvm.listCategories == null) {
      return const Scaffold(
        body: SplashScreen(),
      );
    } else {
      List pages = [
        MainScreen(
          urlImages: hvm.listBannerImages!,
          listCategories: hvm.listCategories!,
          mainData: hvm.mainData!,
        ),
        CategoriesScreen(),
        MyAnnonces(),
        MyAccount(),
      ];
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
            onPressed: () {},
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
