import 'package:ecommerce/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

Widget customButton({
  required Function()? onPressed,
  required String? title,
  required double? topPadding,
  required double? buttonWidth,
}) {
  return Container(
    padding: EdgeInsets.only(top: topPadding!),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        fixedSize: Size(buttonWidth!, 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(08),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title!,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );
}
