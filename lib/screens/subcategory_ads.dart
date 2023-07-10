import 'package:ecommerce/homeViewModel/home_view_model.dart';
import 'package:flutter/material.dart';

import '../core/utils/app_colors.dart';

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
            return Container(
              child: Column(children: [
                Text(hvm.listsubCategory!.subCat![index].name!),
              ]),
            );
          }),
        ),
      ),
    );
  }
}
