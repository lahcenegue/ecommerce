import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import 'button_favorite.dart';

Widget productBox({
  required double widthSceeren,
  required int id,
  required String image,
  required String title,
  required String desc,
  required String price,
  required String created,
  required String userId,
}) {
  return Stack(
    children: [
      Container(
        width: widthSceeren,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 5,
              offset: Offset.fromDirection(8),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                errorBuilder: (context, error, stackTrace) {
                  return const Text('error');
                },
                image,
                width: widthSceeren * 0.25,
                height: widthSceeren * 0.25,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: widthSceeren * 0.03),
            SizedBox(
              width: widthSceeren * 0.6,
              height: widthSceeren * 0.25,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: widthSceeren * 0.5,
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Text(
                    desc,
                    maxLines: 2,
                  ),
                  iconText(price: price, time: created),
                ],
              ),
            ),
          ],
        ),
      ),
      Positioned(
        top: 08,
        left: 08,
        child: ButtonFavorite(
          id: id,
          title: title,
          image: image,
          created: created,
          price: price,
          desc: desc,
          userId: userId,
        ),
      )
    ],
  );
}

Widget iconText({
  required String price,
  required String time,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      const Spacer(),
      Icon(Icons.money_rounded, color: AppColors.primary),
      const SizedBox(width: 03),
      Text(price, style: TextStyle(color: AppColors.primary, fontSize: 14)),
      const Spacer(),
      //
      Icon(Icons.access_time, color: AppColors.primary),
      const SizedBox(width: 03),
      Text(time, style: TextStyle(color: AppColors.primary, fontSize: 14)),
      const Spacer(),
    ],
  );
}
