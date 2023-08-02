import 'package:ecommerce/core/utils/app_colors.dart';
import 'package:ecommerce/homeViewModel/home_view_model.dart';
import 'package:ecommerce/screens/notifications_screen.dart';
import 'package:ecommerce/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import '../ViewModels/categories_viewmodel.dart';
import '../ViewModels/main_view_model.dart';
import '../core/widgets/categories_box.dart';
import '../core/widgets/banner_slider.dart';
import '../core/widgets/product_box.dart';
import 'subcategory_ads.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: heightScreen * 0.35,
                color: AppColors.primary,
                child: Column(
                  children: [
                    Container(
                      height: heightScreen * 0.1,
                      width: widthScreen,
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              showSearch(
                                context: context,
                                delegate: MySearchDelegate(),
                              );
                            },
                            child: SizedBox(
                              width: widthScreen * 0.8,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.search,
                                        size: 32,
                                        color: Colors.white.withOpacity(0.5),
                                      ),
                                      const SizedBox(width: 20),
                                      Text(
                                        'بحث',
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Divider(
                                    height: 2,
                                    color: Colors.white.withOpacity(0.5),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Stack(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const NotificationsScreen(),
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.notifications_none_rounded,
                                  color: Colors.white,
                                  size: 34,
                                ),
                              ),
                              Positioned(
                                top: 12,
                                right: 12,
                                child: Container(
                                  height: 10,
                                  width: 10,
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    BannerSlider(
                      height: heightScreen * 0.25,
                      urlImages:
                          Provider.of<HomeViewModel>(context).listBannerImages!,
                    ),
                  ],
                ),
              ),

              // Categories
              Container(
                padding: const EdgeInsets.only(right: 12, top: 30),
                height: heightScreen * 0.20,
                child: ListView.separated(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: Provider.of<HomeViewModel>(context)
                        .listCategories!
                        .length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 20),
                    itemBuilder: (BuildContext context, int index) {
                      CategoriesViewModel categorie =
                          Provider.of<HomeViewModel>(context)
                              .listCategories![index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SubCategoryAds(
                                title: categorie.name!,
                                id: categorie.id!,
                              ),
                            ),
                          );
                        },
                        child: categoriesBox(
                          name: categorie.name!,
                        ),
                      );
                    }),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 12,
                ),
                child: const Text(
                  'اخر الاعلانات',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              SizedBox(
                child: MasonryGridView.builder(
                  physics: const BouncingScrollPhysics(),
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount:
                      Provider.of<HomeViewModel>(context).mainData!.adsLenght,
                  itemBuilder: (context, index) {
                    MainViewModel mainData =
                        Provider.of<HomeViewModel>(context).mainData!;
                    return productBox(
                      widthSceeren: widthScreen,
                      id: mainData.adsId![index],
                      image: mainData.adsImages![index],
                      title: mainData.adstitle![index],
                      desc: mainData.adsDesc![index],
                      price: mainData.adsPrice![index],
                      created: mainData.adsCreated![index],
                      userId: mainData.adsUserId![index],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
