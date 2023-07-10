import 'package:ecommerce/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../ViewModels/categories_viewmodel.dart';
import '../ViewModels/main_view_model.dart';
import '../core/widgets/categories_box.dart';
import '../core/widgets/banner_slider.dart';
import '../core/widgets/product_box.dart';

class MyAnnonces extends StatelessWidget {
  final List urlImages;
  final List listCategories;
  final MainViewModel mainData;
  const MyAnnonces({
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
        appBar: AppBar(
          centerTitle: true,
          title: const Text('اعلاناتي'),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: MasonryGridView.builder(
            physics: const BouncingScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
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
      ),
    );
  }
}
