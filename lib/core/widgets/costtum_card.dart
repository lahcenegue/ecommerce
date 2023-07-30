import 'package:flutter/material.dart';

Widget custtomCard(
    {required Widget icon, required String title, required Function() onTap}) {
  return Builder(builder: (BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: onTap,
      child: Container(
        height: heightScreen * 0.08,
        margin: const EdgeInsets.symmetric(vertical: 08),
        padding: const EdgeInsets.only(left: 20, right: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(08),
          color: Colors.white,
        ),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 18),
            Text(title),
            const Spacer(),
          ],
        ),
      ),
    );
  });
}
