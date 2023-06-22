import 'package:ecommerce/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../ViewModels/categories_viewmodel.dart';
import '../ViewModels/main_view_model.dart';
import '../core/widgets/categories_box.dart';
import '../core/widgets/banner_slider.dart';
import '../core/widgets/product_box.dart';

class MainScreen extends StatelessWidget {
  final List urlImages;
  final List listCategories;
  final MainViewModel mainData;
  const MainScreen({
    super.key,
    required this.urlImages,
    required this.listCategories,
    required this.mainData,
  });

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        //backgroundColor: Color(0xfff2f2f2),
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
                              print('search');
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
                                  print('notifications');
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
                      urlImages: urlImages,
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
                    itemCount: listCategories.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 20),
                    itemBuilder: (BuildContext context, int index) {
                      CategoriesViewModel categorie = listCategories[index];
                      return GestureDetector(
                        onTap: () {},
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'اخر الاعلانات',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          'المزيد',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ))
                  ],
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                child: MasonryGridView.builder(
                  physics: const BouncingScrollPhysics(),
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                  itemCount: mainData.adsLenght,
                  itemBuilder: (context, index) {
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
