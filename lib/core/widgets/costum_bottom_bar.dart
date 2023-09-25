import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class CustomBottomBar extends StatefulWidget {
  final int selectedIndex;
  final List<CostomNavigationItem>? items;
  const CustomBottomBar({
    super.key,
    required this.selectedIndex,
    this.items,
  });

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  double iconSize = 18;
  double labelSize = 14;

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    return Container(
      width: widthScreen,
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 04),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 1st
          SizedBox(
            width: widthScreen * 0.4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: widget.items![0].onTap,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 08,
                      horizontal: 03,
                    ),
                    width: widget.selectedIndex == 0
                        ? widthScreen * 0.22
                        : widthScreen * 0.15,
                    decoration: BoxDecoration(
                      color: widget.selectedIndex == 0
                          ? AppColors.primary.withOpacity(0.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(08),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          widget.items![0].icon,
                          color: widget.selectedIndex == 0
                              ? AppColors.primary
                              : Colors.black,
                          width: iconSize,
                        ),
                        Visibility(
                          visible: widget.selectedIndex == 0 ? true : false,
                          child: Text(
                            widget.items![0].lebel,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: labelSize,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //الاقسام
                InkWell(
                  onTap: widget.items![1].onTap,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 08, horizontal: 03),
                    width: widget.selectedIndex == 1
                        ? widthScreen * 0.22
                        : widthScreen * 0.15,
                    decoration: BoxDecoration(
                      color: widget.selectedIndex == 1
                          ? AppColors.primary.withOpacity(0.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(08),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          widget.items![1].icon,
                          color: widget.selectedIndex == 1
                              ? AppColors.primary
                              : Colors.black,
                          width: iconSize,
                        ),
                        Visibility(
                          visible: widget.selectedIndex == 1 ? true : false,
                          child: Text(
                            widget.items![1].lebel,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: labelSize,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // space
          SizedBox(width: widthScreen * 0.15),

          //اعلاناتي
          //2 rd
          SizedBox(
            width: widthScreen * 0.4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: widget.items![2].onTap,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 08, horizontal: 03),
                    width: widget.selectedIndex == 2
                        ? widthScreen * 0.22
                        : widthScreen * 0.15,
                    decoration: BoxDecoration(
                      color: widget.selectedIndex == 2
                          ? AppColors.primary.withOpacity(0.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(08),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          widget.items![2].icon,
                          color: widget.selectedIndex == 2
                              ? AppColors.primary
                              : Colors.black,
                          width: iconSize,
                        ),
                        Visibility(
                          visible: widget.selectedIndex == 2 ? true : false,
                          child: Text(
                            widget.items![2].lebel,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: labelSize,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //المزيد
                InkWell(
                  onTap: widget.items![3].onTap,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 08, horizontal: 03),
                    width: widget.selectedIndex == 3
                        ? widthScreen * 0.22
                        : widthScreen * 0.15,
                    decoration: BoxDecoration(
                      color: widget.selectedIndex == 3
                          ? AppColors.primary.withOpacity(0.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(08),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          widget.items![3].icon,
                          color: widget.selectedIndex == 3
                              ? AppColors.primary
                              : Colors.black,
                          width: iconSize,
                        ),
                        Visibility(
                          visible: widget.selectedIndex == 3 ? true : false,
                          child: Text(
                            widget.items![3].lebel,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: labelSize,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CostomNavigationItem {
  final String icon;
  final Function() onTap;
  final String lebel;
  const CostomNavigationItem({
    required this.icon,
    required this.onTap,
    required this.lebel,
  });
}
