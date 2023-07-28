import 'package:ecommerce/core/utils/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../ViewModels/ads_view_model.dart';
import '../ViewModels/main_view_model.dart';
import '../core/widgets/product_box.dart';
import '../homeViewModel/home_view_model.dart';

class MyAnnonces extends StatefulWidget {
  final MainViewModel mainData;
  const MyAnnonces({
    super.key,
    required this.mainData,
  });

  @override
  State<MyAnnonces> createState() => _MyAnnoncesState();
}

class _MyAnnoncesState extends State<MyAnnonces> {
  HomeViewModel hvm = HomeViewModel();

  final controller = ScrollController();
  bool isLoadingMore = false;
  int page = 1;

  List<AdsViewModel> listAds = [];

  @override
  void initState() {
    controller.addListener(_scrollListener);
    hvm.fetchmyAds(
      token: CacheHelper.getData(key: PrefKeys.token),
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
    if (hvm.myAds == null) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('اعلاناتي'),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      listAds = listAds + hvm.myAds!;
      return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('اعلاناتي'),
            ),
            body: MasonryGridView.builder(
              controller: controller,
              physics: const BouncingScrollPhysics(),
              mainAxisSpacing: 32,
              crossAxisSpacing: 18,
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              gridDelegate:
                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
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
            )),
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
            .fetchmyAds(
          token: CacheHelper.getData(key: PrefKeys.token),
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
