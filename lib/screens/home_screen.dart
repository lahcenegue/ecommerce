import 'package:ecommerce/core/utils/app_colors.dart';
import 'package:ecommerce/screens/my_account.dart';
import 'package:ecommerce/screens/my_announces.dart';
import 'package:ecommerce/screens/splash_screen.dart';
import 'package:flutter/material.dart';

import '../core/utils/app_icons.dart';
import '../core/widgets/constum_button.dart';
import '../core/widgets/costum_bottom_bar.dart';
import '../core/widgets/text_form.dart';
import '../homeViewModel/home_view_model.dart';
import 'gategories.dart';
import 'main_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewModel hvm = HomeViewModel();

  int _currentStep = 0;

  @override
  void initState() {
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
    double widthScreen = MediaQuery.of(context).size.width;
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
        CategoriesScreen(
          categories: hvm.listCategories!,
        ),
        MyAnnonces(
          urlImages: hvm.listBannerImages!,
          listCategories: hvm.listCategories!,
          mainData: hvm.mainData!,
        ),
        const MyAccount(),
      ];
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return StatefulBuilder(builder: (context, setState) {
                      return AlertDialog(
                        title: const Text(
                          'اضف اعلان',
                          textAlign: TextAlign.center,
                        ),
                        content: SizedBox(
                          width: widthScreen,
                          height: heightScreen * 0.7,
                          child: Stepper(
                            currentStep: _currentStep,
                            type: StepperType.horizontal,
                            onStepTapped: (int index) {
                              setState(() {
                                _currentStep = index;
                              });
                            },
                            onStepContinue: () {
                              setState(() {
                                _currentStep += 1;
                              });
                            },
                            onStepCancel: () {
                              if (_currentStep > 0) {
                                setState(() {
                                  _currentStep -= 1;
                                });
                              } else {
                                Navigator.pop(context);
                              }
                            },
                            steps: [
                              Step(
                                isActive: _currentStep >= 0,
                                title: const Text(''),
                                content: Column(
                                  children: [
                                    Text('etape 1 '),
                                    customTextFormField(
                                        keyboardType: TextInputType.text,
                                        prefixIcon: Icons.person,
                                        hintText: 'اسم الاعلان'),
                                  ],
                                ),
                              ),
                              Step(
                                isActive: _currentStep >= 1,
                                title: const Text(''),
                                content: Column(
                                  children: [
                                    Text('etape 2 '),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    });
                  });
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
