import 'package:ecommerce/core/utils/app_icons.dart';
import 'package:flutter/material.dart';

Widget iconPiker(String category) {
  Widget iconData;
  switch (category) {
    case "محركات":
      {
        iconData = Image.asset(AppIcons.cars);
      }
      break;

    case "عقارات":
      {
        iconData = Image.asset(AppIcons.akarat);
      }
      break;

    case "حيوانات":
      {
        iconData = Image.asset(AppIcons.animals);
      }
      break;

    case "بيع وشراء":
      {
        iconData = Image.asset(AppIcons.vente);
      }
      break;

    case "خدمات":
      {
        iconData = Image.asset(AppIcons.services);
      }
      break;

    case "وظائف":
      {
        iconData = Image.asset(AppIcons.wadaif);
      }
      break;
    case "إلكترونيات":
      {
        iconData = Image.asset(AppIcons.electronics);
      }
      break;

    default:
      {
        iconData = Image.asset(AppIcons.cars);
      }
      break;
  }

  return iconData;
}
