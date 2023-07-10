import 'package:ecommerce/core/utils/app_colors.dart';
import 'package:ecommerce/core/widgets/button_favorite.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../core/utils/app_links.dart';
import '../core/widgets/image_slider.dart';
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
          padding: const EdgeInsets.all(10),
          width: widthScreen,
          height: heightScreen * 0.09,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Row(
            children: [
              Container(
                height: widthScreen * 0.12,
                width: widthScreen * 0.12,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 08),
              Text(
                'ابو عبد المحسن',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: heightScreen * 0.018,
                ),
              ),
              const Spacer(),
              Container(
                height: widthScreen * 0.12,
                width: widthScreen * 0.12,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Center(
                  child: Icon(
                    Icons.phone,
                    size: heightScreen * 0.03,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 05),
              Container(
                height: widthScreen * 0.12,
                width: widthScreen * 0.12,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Center(
                  child: Icon(
                    Icons.message,
                    size: heightScreen * 0.03,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 05),
              Container(
                height: widthScreen * 0.12,
                width: widthScreen * 0.12,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Center(
                  child: Icon(
                    Icons.perm_phone_msg,
                    size: heightScreen * 0.03,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: widthScreen,
              height: heightScreen * 0.4,
              child: Stack(
                children: [
                  ImagesSlider(
                    urlImages: hvm.adsData!.images!,
                    height: heightScreen * 0.4,
                  ),
                  Positioned(
                    top: heightScreen * 0.05,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      width: widthScreen,
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: widthScreen * 0.08,
                              )),
                          const Spacer(),
                          ButtonFavorite(
                            size: widthScreen * 0.08,
                            id: hvm.adsData!.id,
                            title: hvm.adsData!.title,
                            image: hvm.adsData!.images![0],
                            created: hvm.adsData!.created,
                            price: hvm.adsData!.price,
                            desc: hvm.adsData!.desc,
                            userId: hvm.adsData!.userId,
                          ),
                          SizedBox(width: widthScreen * 0.01),
                          IconButton(
                            onPressed: () {
                              Share.share(
                                  'Discover this product ${AppLinks.mainLink}/play/${hvm.adsData!.id}');
                            },
                            icon: Icon(
                              Icons.share,
                              color: Colors.white,
                              size: widthScreen * 0.08,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: widthScreen * 0.65,
                        child: Text(
                          hvm.adsData!.title!,
                          style: TextStyle(
                            fontSize: widthScreen * 0.05,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Text(
                        hvm.adsData!.price! == 'None'
                            ? hvm.adsData!.price!
                            : '${hvm.adsData!.price!} ريال',
                        style: TextStyle(
                          fontSize: widthScreen * 0.05,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    hvm.adsData!.desc!,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: widthScreen * 0.04,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}
