import 'package:ecommerce/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('المساعدة'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              height: heightScreen * 0.25,
              width: widthScreen,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[300],
              ),
              child: const Center(
                child: Text('Same illustration'),
              ),
            ),
            SizedBox(height: heightScreen * 0.05),
            Container(
              padding: const EdgeInsets.all(12),
              width: widthScreen,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.primary,
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.email_rounded,
                    size: heightScreen * 0.05,
                    color: Colors.white,
                  ),
                  Text(
                    'ارسل بريد الكتروني',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: heightScreen * 0.025,
                    ),
                  ),
                  SizedBox(height: heightScreen * 0.015),
                  Text(
                    'support@sooq.com',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: heightScreen * 0.022,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: heightScreen * 0.025),
            Container(
              padding: const EdgeInsets.all(12),
              width: widthScreen,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.primary,
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.phone,
                    size: heightScreen * 0.05,
                    color: Colors.white,
                  ),
                  Text(
                    'اتصل بنا',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: heightScreen * 0.025,
                    ),
                  ),
                  SizedBox(height: heightScreen * 0.015),
                  Text(
                    '00965 555 555 555',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: heightScreen * 0.022,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
