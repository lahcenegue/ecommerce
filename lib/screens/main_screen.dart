import 'package:ecommerce/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import '../ViewModels/categories_viewmodel.dart';
import '../core/widgets/categories_box.dart';
import '../core/widgets/images_slider.dart';
import '../core/widgets/product_box.dart';
import '../homeViewModel/home_view_model.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  HomeViewModel hvm = HomeViewModel();

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

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    hvm.addListener(() {
      setState(() {});
    });
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: hvm.mainData == null || hvm.listCategories == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
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
                                              color:
                                                  Colors.white.withOpacity(0.5),
                                            ),
                                            const SizedBox(width: 20),
                                            Text(
                                              'بحث',
                                              style: TextStyle(
                                                color: Colors.white
                                                    .withOpacity(0.5),
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
                          ImagesSlider(
                            height: heightScreen * 0.25,
                            urlImages: hvm.listBannerImages!,
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
                          itemCount: hvm.listCategories!.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 20),
                          itemBuilder: (BuildContext context, int index) {
                            CategoriesViewModel categorie =
                                hvm.listCategories![index];
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
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: hvm.adsLenght,
                        itemBuilder: (context, index) {
                          return productBox(
                            widthSceeren: widthScreen,
                            id: hvm.listAdsId![index],
                            image: hvm.listAdsImages![index],
                            title: hvm.listAdsTitle![index],
                            desc: hvm.listAdsDesc![index],
                            price: hvm.listAdsPrice![index],
                            created: hvm.listAdsCreated![index],
                            userId: hvm.listAdsUserId![index],
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
