import 'package:ecommerce/core/utils/app_icons.dart';
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
        height: widthSceeren * 0.6,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Container(
              width: widthSceeren * 0.45,
              height: widthSceeren * 0.43,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                width: widthSceeren * 0.44,
                height: widthSceeren * 0.22,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(flex: 1),
                    Text(
                      desc,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color(0xffc1c1c1),
                      ),
                    ),
                    const Spacer(flex: 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          AppIcons.money,
                          width: widthSceeren * 0.05,
                        ),
                        const SizedBox(width: 08),
                        Text(price),
                        const Spacer(),
                        Text(
                          'منذ $created',
                          style: const TextStyle(
                            color: Color(0xffc1c1c1),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      ///////
      ButtonFavorite(
        id: id,
        title: title,
        image: image,
        created: created,
        price: price,
        desc: desc,
        userId: userId,
      ),
    ],
  );
}





//             SizedBox(
//               width: widthSceeren * 0.6,
//               height: widthSceeren * 0.25,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     width: widthSceeren * 0.5,
//                     child: Text(
//                       title,
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(
//                         color: AppColors.primary,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                   Text(
//                     desc,
//                     maxLines: 2,
//                   ),
//                   iconText(price: price, time: created),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       Positioned(
//         top: 08,
//         left: 08,

//       )
//     ],
//   );
