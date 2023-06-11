import 'package:flutter/material.dart';

Widget categoriesBox({
  required String name,
  String? image,
}) {
  return Column(
    children: [
      Container(
        margin: const EdgeInsets.all(04),
        padding: const EdgeInsets.all(5),
        width: 60,
        height: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0XffDFDAFF),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      Text(
        name,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      )
    ],
  );
}
