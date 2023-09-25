import 'package:flutter/material.dart';

Widget lancherBox({
  required double width,
  required Function() onTap,
  required IconData icon,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: width * 0.12,
      width: width * 0.12,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Center(
        child: Icon(
          icon,
          size: width * 0.06,
          color: Colors.white,
        ),
      ),
    ),
  );
}
