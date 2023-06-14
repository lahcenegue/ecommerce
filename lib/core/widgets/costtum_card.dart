import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

Widget custtomCard({required Widget icon, required String title}) {
  return Builder(builder: (BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;

    return Container(
      height: heightScreen * 0.08,
      margin: const EdgeInsets.symmetric(vertical: 08),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(08),
        color: Colors.white,
      ),
      child: Row(
        children: [
          icon,
          const SizedBox(width: 10),
          Text(title),
          const Spacer(),
          Icon(Icons.abc)
        ],
      ),
    );
  });
}
