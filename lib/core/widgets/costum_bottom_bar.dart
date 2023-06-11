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
  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    return Container(
      width: widthScreen,
      padding: const EdgeInsets.symmetric(horizontal: 05),
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: widthScreen * 0.40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: widget.items![0].onTap,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 08, horizontal: 03),
                    width: widthScreen * 0.19,
                    decoration: BoxDecoration(
                      color: widget.selectedIndex == 0
                          ? AppColors.primary.withOpacity(0.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(08),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          widget.items![0].icon,
                          color: widget.selectedIndex == 0
                              ? AppColors.primary
                              : Colors.black,
                          width: 18,
                        ),
                        Visibility(
                          visible: widget.selectedIndex == 0 ? true : false,
                          child: Text(
                            widget.items![0].lebel,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
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
                    width: widthScreen * 0.19,
                    decoration: BoxDecoration(
                      color: widget.selectedIndex == 1
                          ? AppColors.primary.withOpacity(0.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(08),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          widget.items![1].icon,
                          color: widget.selectedIndex == 1
                              ? AppColors.primary
                              : Colors.black,
                          width: 18,
                        ),
                        Visibility(
                          visible: widget.selectedIndex == 1 ? true : false,
                          child: Text(
                            widget.items![1].lebel,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
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
          SizedBox(width: widthScreen * 0.19),

          //اعلاناتي
          SizedBox(
            width: widthScreen * 0.38,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: widget.items![2].onTap,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 08, horizontal: 03),
                    width: widthScreen * 0.19,
                    decoration: BoxDecoration(
                      color: widget.selectedIndex == 2
                          ? AppColors.primary.withOpacity(0.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(08),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          widget.items![2].icon,
                          color: widget.selectedIndex == 2
                              ? AppColors.primary
                              : Colors.black,
                          width: 18,
                        ),
                        Visibility(
                          visible: widget.selectedIndex == 2 ? true : false,
                          child: Text(
                            widget.items![2].lebel,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
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
                    width: widthScreen * 0.19,
                    decoration: BoxDecoration(
                      color: widget.selectedIndex == 3
                          ? AppColors.primary.withOpacity(0.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(08),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          widget.items![3].icon,
                          color: widget.selectedIndex == 3
                              ? AppColors.primary
                              : Colors.black,
                          width: 18,
                        ),
                        Visibility(
                          visible: widget.selectedIndex == 3 ? true : false,
                          child: Text(
                            widget.items![3].lebel,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
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
