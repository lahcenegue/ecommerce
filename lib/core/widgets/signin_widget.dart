import 'package:flutter/material.dart';

import '../../screens/login_mobile_screen.dart';
import 'constum_button.dart';

Widget signinWidget() {
  return Builder(
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'الرجاء تسجيل الدخول أولاً للوصول إلى جميع الميزات الموجودة في Sooq.in',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.022),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            customButton(
              buttonWidth: MediaQuery.of(context).size.width,
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginMobileScreen(),
                    ));
              },
              title: 'تسجيل الدخول',
              topPadding: 08,
            ),
          ],
        ),
      );
    },
  );
}
