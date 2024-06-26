import 'package:ecommerce/core/utils/app_colors.dart';
import 'package:ecommerce/core/widgets/icon_piker.dart';
import 'package:ecommerce/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../homeViewModel/home_view_model.dart';
import 'subcategory_ads.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: Provider.of<HomeViewModel>(context).listCategories!.length,
      //length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('الأقسام'),
          actions: [
            IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: MySearchDelegate(),
                );
              },
              icon: const Icon(
                Icons.search,
              ),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(
              AppBar().preferredSize.height,
            ),
            child: SizedBox(
              height: heightScreen * 0.08,
              child: TabBar(
                isScrollable: true,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.transparent,
                unselectedLabelStyle: const TextStyle(fontSize: 0),
                labelStyle: TextStyle(
                  fontSize: heightScreen * 0.02,
                  fontWeight: FontWeight.bold,
                ),
                padding: const EdgeInsets.all(08),
                indicator: BoxDecoration(
                  color: AppColors.secondary.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(08),
                ),
                tabs: List.generate(
                  Provider.of<HomeViewModel>(context).listCategories!.length,
                  (index) {
                    return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 05),
                        child: Row(
                          children: [
                            SizedBox(
                                height: heightScreen * 0.03,
                                child: iconPiker(
                                  Provider.of<HomeViewModel>(context)
                                      .listCategories![index]
                                      .name!,
                                )),
                            const SizedBox(width: 08),
                            Text(Provider.of<HomeViewModel>(context)
                                .listCategories![index]
                                .name!),
                          ],
                        ));
                  },
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: List.generate(
              Provider.of<HomeViewModel>(context).listCategories!.length,
              (index) {
            return SubCatWidget(
                subCat: Provider.of<HomeViewModel>(context)
                    .listCategories![index]
                    .subCat!);
          }),
        ),
      ),
    );
  }
}

class SubCatWidget extends StatelessWidget {
  final List subCat;
  const SubCatWidget({
    super.key,
    required this.subCat,
  });

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    return MasonryGridView.builder(
      physics: const BouncingScrollPhysics(),
      mainAxisSpacing: 32,
      crossAxisSpacing: 18,
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: subCat.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SubCategoryAds(
                  title: subCat[index].name,
                  id: subCat[index].id,
                ),
              ),
            );
          },
          child: Container(
            height: widthScreen * 0.4,
            width: widthScreen * 0.4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.primary,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.car_rental,
                  color: AppColors.secondary,
                  size: widthScreen * 0.15,
                ),
                const SizedBox(height: 10),
                Text(
                  subCat[index].name,
                  style: TextStyle(
                    fontSize: widthScreen * 0.05,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
