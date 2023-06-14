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
            Visibility(
              visible: title == 'تفعيل الاشعارات' ? true : false,
              child: Switch(
                  // activeColor: Colors.grey,
                  // activeTrackColor: Colors.grey.withOpacity(0.5),
                  //inactiveThumbColor: Colors.blueGrey.shade600,
                  //inactiveTrackColor: Colors.grey.shade400,
                  //splashRadius: 30.0,
                  value: true,
                  onChanged: (value) {}),
            ),
          ],
        ),
      ),
    );
  });
}
