import 'package:ecommerce/homeViewModel/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../ViewModels/ads_view_model.dart';
import '../core/utils/app_colors.dart';
import '../core/widgets/product_box.dart';

class SubCategoryAds extends StatefulWidget {
  final String title;
  final int id;
  const SubCategoryAds({
    super.key,
    required this.title,
    required this.id,
  });

  @override
  State<SubCategoryAds> createState() => _SubCategoryAdsState();
}

class _SubCategoryAdsState extends State<SubCategoryAds> {
  HomeViewModel hvm = HomeViewModel();

  @override
  void initState() {
    hvm.fetchSubCategory(id: widget.id);
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
    hvm.addListener(() {
      setState(() {});
    });

    if (hvm.listsubCategory == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return DefaultTabController(
      length: hvm.listsubCategory!.subCat!.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
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
                  fontWeight: FontWeight.w600,
                ),
                padding: const EdgeInsets.all(08),
                indicator: BoxDecoration(
                  color: AppColors.secondary.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(08),
                ),
                tabs: List.generate(
                  hvm.listsubCategory!.subCat!.length,
                  (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 05),
                      child: Row(
                        children: [
                          Icon(
                            Icons.category_rounded,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 04),
                          Text(hvm.listsubCategory!.subCat![index].name!),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: List.generate(hvm.listsubCategory!.subCat!.length, (index) {
            return SubCatAds(id: hvm.listsubCategory!.subCat![index].id!);
          }),
        ),
      ),
    );
  }
}

class SubCatAds extends StatefulWidget {
  final int id;
  const SubCatAds({
    super.key,
    required this.id,
  });

  @override
  State<SubCatAds> createState() => _SubCatAdsState();
}

class _SubCatAdsState extends State<SubCatAds> {
  HomeViewModel hvm = HomeViewModel();

  final controller = ScrollController();
  bool isLoadingMore = false;
  int page = 1;

  List<AdsViewModel> listAds = [];

  @override
  void initState() {
    controller.addListener(_scrollListener);
    hvm.fetchSubCatAds(
      id: widget.id,
      page: page,
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    hvm.addListener(() {
      setState(() {});
    });
    if (hvm.subCatAds == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      listAds = listAds + hvm.subCatAds!;
      return MasonryGridView.builder(
        controller: controller,
        physics: const BouncingScrollPhysics(),
        mainAxisSpacing: 32,
        crossAxisSpacing: 18,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: isLoadingMore ? listAds.length + 1 : listAds.length,
        itemBuilder: (context, index) {
          if (index < listAds.length) {
            return productBox(
              widthSceeren: widthScreen,
              id: listAds[index].id!,
              image: listAds[index].images![0],
              title: listAds[index].title!,
              desc: listAds[index].desc!,
              price: listAds[index].price!,
              created: listAds[index].created!,
              userId: listAds[index].userId!,
            );
          } else {
            return const Row(
              children: [
                Spacer(),
                CircularProgressIndicator(),
              ],
            );
          }
        },
      );
    }
  }

  Future<void> _scrollListener() async {
    if (isLoadingMore) return;
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      setState(() {
        isLoadingMore = true;
      });
      await Future.delayed(const Duration(seconds: 2)).then((value) async {
        setState(() {
          page = page + 1;
        });

        await hvm
            .fetchSubCatAds(
          id: widget.id,
          page: page,
        )
            .then((value) {
          setState(
            () {
              isLoadingMore = false;
            },
          );
        });
      });
    }
  }
}
