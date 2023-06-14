import 'package:ecommerce/core/utils/app_colors.dart';
import 'package:ecommerce/core/widgets/button_favorite.dart';
import 'package:flutter/material.dart';

import '../homeViewModel/home_view_model.dart';

class AdsScreen extends StatefulWidget {
  final int id;
  const AdsScreen({
    super.key,
    required this.id,
  });

  @override
  State<AdsScreen> createState() => _AdsScreenState();
}

class _AdsScreenState extends State<AdsScreen> {
  HomeViewModel hvm = HomeViewModel();
  @override
  void initState() {
    hvm.fetchAds(id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    hvm.addListener(() {
      setState(() {});
    });
    if (hvm.adsData == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          width: widthScreen,
          height: heightScreen * 0.09,
          decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(40)),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: widthScreen,
              height: heightScreen * 0.4,
              decoration: const BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: heightScreen * 0.1,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      width: widthScreen,
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.arrow_back)),
                          const Spacer(),
                          const Icon(Icons.favorite),
                          SizedBox(width: widthScreen * 0.01),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.share),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    child: Icon(Icons.abc),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(hvm.adsData!.title!),
                Text(hvm.adsData!.price!),
              ],
            ),
            Text(hvm.adsData!.desc!)
          ],
        ),
      );
    }
  }
}
